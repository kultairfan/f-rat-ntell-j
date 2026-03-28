package com.macfit.runners;

import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(
        features = "src/test/resources/features/LeadYonetimi/1b.feature",
        glue = {
                "com.macfit.steps.LeadYonetimi",
                "com.macfit.steps"
        },
        plugin = {
                "pretty",
                "html:target/cucumber-reports/LeadPortalFlow/report.html",
                "json:target/cucumber-reports/LeadPortalFlow/report.json"
        },
        tags = "@1b1 or @1b2 or @1b3 or @1b4 or @1b5 or @1b6",
        dryRun = false
)
public class LeadPortalFlowRunner {
    // Tag örnekleri:
    // tags = "@1A1"            → sadece 1A1
    // tags = "@withoutOTP"     → OTP'siz tüm senaryolar
    // tags = "@withOTP"        → OTP'li tüm senaryolar
    // tags = "@1A1 or @1A2"    → belirli senaryolar
}
