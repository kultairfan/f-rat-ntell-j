package com.macfit.runners;

import org.junit.runner.RunWith;

import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;

@RunWith(Cucumber.class)
@CucumberOptions(

		
		features = "src/test/resources/features/",
		glue = "com.macfit.steps",
		
		dryRun = false,

		
		monochrome = true,

		
		tags = "@ela",

		plugin = {
				
				"pretty",
				"html:target/cucumber-default-report.html",
				"json:target/cucumber.json" }

)

public class TestRunner {

}
