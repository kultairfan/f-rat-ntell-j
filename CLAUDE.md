# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Selenium + Cucumber BDD test automation framework for the MacFit/Mars Athletic platform (Turkish fitness membership system). Tests are written in Turkish (method names, step descriptions, locators).

## Build & Run Commands

```bash
# Compile
mvn clean compile

# Run specific runner
mvn test -Dtest=TestRunner             # @olympus tag — default smoke tests
mvn test -Dtest=RegressionRunner       # @ela tag — full regression
mvn test -Dtest=LeadPortalFlowRunner   # @1A1, @withOTP, @withoutOTP tags
mvn test -Dtest=FailedRunner           # Re-runs scenarios listed in target/failed.txt
```

Surefire is configured to pick up `*TestRunner.java` automatically, so `mvn test` runs all runners.

## Architecture

**Stack:** Java 17 · Selenium 4 · Cucumber 7 · JUnit 4 · MySQL (JDBC) · Apache POI (Excel)

### Layer Structure

```
src/test/java/com/macfit/
├── runners/       Cucumber JUnit runners — one per tag group
├── pages/         Page Object Models — locators + business-level methods
├── steps/         Cucumber step definitions + Hooks (Before/After lifecycle)
├── testbase/      BaseClass (static WebDriver, setUp/tearDown) + PageInitializer
└── utils/         CommonMethods, ConfigsReader, DatabaseHelper, ExcelUtility, Constants, TestData
```

### Key Classes

**`BaseClass`** — Static WebDriver instance, `setUp()` (reads config, launches browser), `tearDown()`. Contains inner `BasePage` with ~20 Turkish-named Selenium helpers (`tusaBas`, `yaziYaz`, `bekle`, `sekmeyeGec`, etc.).

**`CommonMethods`** — Extends `PageInitializer` → `BaseClass`. ~60 utility methods: waits, clicks with retry on `StaleElementReferenceException`, JS execution, alerts, frames, window switching, `takeScreenshot()`, calendar date picker.

**`Hooks`** — `@Before` calls `setUp()`; `@After` takes a timestamped screenshot to `screenshots/passed/` or `screenshots/failed/`, attaches it to the Cucumber report, then calls `tearDown()`.

**`DatabaseHelper`** — JDBC to MySQL at 10.10.100.81:3306. Primary use: `smsCodeGetir(String telefon)` — fetches the latest OTP/SMS code for phone-verified flows.

**Page classes** extend `CommonMethods` directly and define `By` locators as fields alongside business methods.

### Configuration

`src/test/resources/configs/configuration.properties` — browser, URL, credentials, member number.

`src/test/resources/cucumber.properties` — glue path (`com.macfit.steps`), publish settings.

`Constants.java` — implicit wait (10 s), explicit wait (15 s), file paths for reports and screenshots.

### Test Artifacts

| Artifact | Location |
|---|---|
| HTML report | `target/cucumber-default-report.html` |
| JSON report | `target/cucumber.json` |
| Failed rerun list | `target/failed.txt` |
| Screenshots | `screenshots/failed/` · `screenshots/passed/` |

### Feature Files

Located in `src/test/resources/features/`. Lead portal scenarios are in the `LeadYonetimi/` subdirectory.

## Patterns & Conventions

- All page methods, step definitions, and many locator strings use **Turkish** (consistent with the product domain).
- Page objects inherit `CommonMethods` (not just `WebDriver`); call `CommonMethods` utility methods rather than raw Selenium.
- `FailedRunner` reads `@target/failed.txt` — always run it after a failed suite to confirm flakiness vs real failures.
- Excel test data loaded via `ExcelUtility.excelIntoArray()` for data-driven scenarios.
