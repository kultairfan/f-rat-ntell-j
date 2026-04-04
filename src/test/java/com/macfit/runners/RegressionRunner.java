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
		tags = "@4a",
		dryRun = false

)

public class RegressionRunner {

}
