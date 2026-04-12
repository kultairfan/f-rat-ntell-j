package com.macfit.runners;

import org.junit.runner.RunWith;

import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;

@RunWith(Cucumber.class)
@CucumberOptions(


		features = {"src/test/resources/features"},
		glue = {
				"com.macfit.steps.LeadYonetimi",
				"com.macfit.steps"
		},
		plugin = {
				"pretty",
				"html:target/cucumber-reports/LeadPortalFlow/report.html",
				"json:target/cucumber-reports/LeadPortalFlow/report.json"
		},
		tags = "@1a6 or @1a7 or @2a9 or @3a7 or @3b7 or @4b6",
		dryRun = false

)

public class RegressionRunner {

}
