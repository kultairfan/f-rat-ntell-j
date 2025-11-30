package com.macfit.runners;

import org.junit.runner.RunWith;

import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;

@RunWith(Cucumber.class)
@CucumberOptions(

		
		features = "@target/failed.txt",
		glue = "com.macfit.steps",
		
		dryRun = false,

		
		monochrome = true,

		
		
		plugin = {
//				
//				//"pretty",
//				"html:target/cucumber-default-report.html",
//				"json:target/cucumber.json",
			"rerun:target/failed.txt"
			}

)

public class FailedRunner {

}
