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
		tags = "@1a or @1b or @2a or @2b or @3a or @3b or @4a or @4b",
		dryRun = false

)

public class RegressionRunner {

}
