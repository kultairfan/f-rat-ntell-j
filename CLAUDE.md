# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Selenium + Cucumber BDD test automation framework for the MacFit/Mars Athletic platform (Turkish fitness membership system). Tests are written in Turkish (method names, step descriptions, locators).

**Stack:** Java 17 · Selenium 4.28.0 · Cucumber 7.18.1 · JUnit 4.13.2 · MySQL 8.4.0 (HikariCP 5.1.0) · Apache POI 5.3.0

## Build & Run Commands

```bash
# Compile
mvn clean compile

# Run specific runner
mvn test -Dtest=TestRunner              # @olympus — smoke tests (login, subscription, payment)
mvn test -Dtest=RegressionRunner        # @4b1 or @4b2 or @4b5 or @4b9 — regression
mvn test -Dtest=LeadPortalFlowRunner    # @1a2 @3a2 @3a5 @3a7 @3a9 @3a10 @4a5 @4a7 @4a10
mvn test -Dtest=FailedRunner            # Re-runs scenarios listed in target/failed.txt
```

Surefire picks up `**/*TestRunner.java` automatically, so `mvn test` runs all runners.

## Architecture

### Layer Structure

```
src/test/java/com/macfit/
├── runners/       Cucumber JUnit runners — one per tag group
├── pages/         Page Object Models — locators + business-level methods
├── steps/         Cucumber step definitions + Hooks (Before/After lifecycle)
│   └── LeadYonetimi/  Lead portal flow step definitions
├── testbase/      BaseClass (static WebDriver, setUp/tearDown) + PageInitializer
└── utils/         CommonMethods, ConfigsReader, DatabaseHelper, ExcelUtility,
                   Constants, TestData, SoftAssertionCollector
```

### Runners

| Class | Tags | Notes |
|---|---|---|
| `TestRunner` | `@olympus` | Smoke tests: login, subscription, payment |
| `RegressionRunner` | `@4b1 or @4b2 or @4b5 or @4b9` | Regression subset |
| `LeadPortalFlowRunner` | `@1a2 @3a2 @3a5 @3a7 @3a9 @3a10 @4a5 @4a7 @4a10` | Lead portal flows |
| `FailedRunner` | — | Reads `@target/failed.txt` for rerun |

### Page Classes (`pages/`)

| Class | Domain |
|---|---|
| `OlympusPage` | Olympus dashboard — login, member search, task assignment. Has `useOlympusSu` flag to switch between `olympus.su` and `test.st5` accounts |
| `JoinUsPage` | Join-Us portal form — signup, plan selection, OTP verification |
| `DijitalUyelikPage` | Digital membership form portal — name, phone, city, club, OTP |
| `AdayUyePage` | Candidate member (aday uye) modal in Olympus — prospect creation |
| `AvmDisiPage` | AVM Disi off-site event registration form (uses `@FindBy`) |
| `GorevAtamaPage` | Task assignment modal (Gorev Atama) — follow-up task with reason codes |

### Step Definition Files (`steps/`)

| Class | Package | Scope |
|---|---|---|
| `Hooks` | `com.macfit.steps` | `@Before` (setUp, sets `useOlympusSu` from scenario tags) · `@After` (screenshot, soft-assertion report, tearDown) |
| `OlympusLoginSteps` | `com.macfit.steps` | Olympus login steps |
| `LeadPortalFlowSteps` | `com.macfit.steps.LeadYonetimi` | Primary steps for all lead scenarios (1a–4b). Manages static `randomGsmNo` shared across portal submissions in one scenario |
| `AvmDisiSteps` | `com.macfit.steps.LeadYonetimi` | AVM Disi event form steps |
| `PortalDirectSteps` | `com.macfit.steps.LeadYonetimi` | Direct portal form submission without Join-Us |
| `WebFormGenerate` | `com.macfit.steps` | Standalone utility — WebForm generation (has `main()`) |
| `DijitalKulupSecmeSteps` | `com.macfit.steps` | Standalone utility — digital club selection demo (has `main()`) |
| `Sedas` | `com.macfit.steps.LeadYonetimi` | Standalone utility — frame/reCAPTCHA demo (has `main()`) |

### Utility Classes (`utils/`)

| Class | Purpose |
|---|---|
| `CommonMethods` | ~60 Selenium utilities: `sendText`, waits, click-with-retry, JS execution, alerts, frames, window switching, `takeScreenshot()`, calendar picker. Extends `PageInitializer` → `BaseClass`. |
| `DatabaseHelper` | HikariCP → MySQL at 10.10.100.213:3306 (stage). `smsCodeGetir(String telefon)` fetches latest OTP from `Messaging.SmsCodes` |
| `SoftAssertionCollector` | ThreadLocal soft assertion accumulator. `add(String)`, `hasErrors()`, `getReport()`, `clear()`. Errors reported at end of `@After` hook |
| `TestData` | `generatePhone()` — random Turkish GSM number in `59XXXXXXXX` format for test isolation |
| `ExcelUtility` | Apache POI wrapper. `excelIntoArray(filePath, sheetName)` → `Object[][]` |
| `ConfigsReader` | Reads `configuration.properties`. `getProperty(String key)` static accessor |
| `Constants` | `IMPLICIT_WAIT_TIME=10s`, `EXPLICIT_WAIT_TIME=15s`, `LOADER_WAIT_TIME=20s`, report/screenshot paths |

### Configuration

`src/test/resources/configs/configuration.properties`:
```
browser=chrome
url=https://olympusstg-dashboard.marsathletic.com/auth/login
username=test.st5            # default Olympus account
olympusu.username=olympus.su # alternate account used for 1a/1b scenarios
uyeNo=5572438
```

`src/test/resources/cucumber.properties` — glue path, publish settings.

### Feature Files

Root `src/test/resources/features/`:

| File | Tags | Scope |
|---|---|---|
| `olympusLogin.feature` | `@olympus` | Login, subscription, payment |
| `Portal.feature` | `@PortalDirect @withoutOTP` | Direct portal form (Scenario Outline) |
| `subscriton.feature` | `@avm` | AVM Disi event form |
| `Dijitalkulupdegistir.feature` | `@dijital` | Digital club change flow |
| `WebForm.feature` | `@Webform` | WebForm generation, image upload |

`src/test/resources/features/LeadYonetimi/` — Lead management matrix (SMS approved/unapproved × same/different name × same/different club):

| File | Tags | State |
|---|---|---|
| `1a.feature` | `@1a1`–`@1a10` | SMS unapproved, same name, different club |
| `1b.feature` | `@1b1`, `@1b2` | SMS approved, same name, different club |
| `2a.feature` | `@2a1`, `@2a2` | SMS unapproved, same name, same club |
| `2b.feature` | `@2b1` | SMS approved, same name, same club |
| `3a.feature` | `@3a1`, `@3a2`+ | SMS unapproved, different name, same club |
| `3b.feature` | `@3b1`, `@3b2`+ | SMS approved, different name, same club |
| `4a.feature` | `@4a1`+ | SMS unapproved, different name, different club |
| `4b.feature` | `@4b1`+ | SMS approved, different name, different club |
| `LeadPortalFlow.feature` | `@1A2` | Aday Uye → Digital membership / Join-Us |
| `1a2_satis.feature` | `@1a1test`, `@1a2test` | Test variants of 1a |

All LeadYonetimi scenarios use **Scenario Outline + Examples** for data-driven parameterization.

### Test Artifacts

| Artifact | Location |
|---|---|
| HTML report | `target/cucumber-default-report.html` |
| JSON report | `target/cucumber.json` |
| Failed rerun list | `target/failed.txt` |
| Screenshots | `screenshots/failed/` · `screenshots/passed/` |

## Patterns & Conventions

- All page methods, step definitions, and many locator strings use **Turkish**.
- Page objects extend `CommonMethods` — use its utility methods, not raw Selenium.
- `useOlympusSu` flag in `Hooks` switches accounts based on scenario tags: `olympus.su` for 1a/1b, `test.st5` for all others.
- `randomGsmNo` in `LeadPortalFlowSteps` is static and shared across portal form steps within a scenario; reset in `@Before`.
- `SoftAssertionCollector` defers assertion failures to `@After` — allows a scenario to complete fully before reporting errors.
- `FailedRunner` reads `@target/failed.txt` — run it after a failed suite to distinguish flakiness from real failures.
- Excel test data loaded via `ExcelUtility.excelIntoArray()` for data-driven scenarios.
- Standalone classes with `main()` methods (`WebFormGenerate`, `DijitalKulupSecmeSteps`, `Sedas`) are for manual/exploratory use, not Cucumber execution.
