package com.macfit.steps;

import com.macfit.pages.OlympusPage;
import com.macfit.steps.LeadYonetimi.LeadPortalFlowSteps;
import com.macfit.utils.CommonMethods;
import com.macfit.utils.SoftAssertionCollector;

import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.cucumber.java.Scenario;

import java.util.Collection;

public class Hooks extends CommonMethods{

	@Before
	public void start(Scenario scenario)
	{
		LeadPortalFlowSteps.resetGsmNo();
		// 1a ve 1b feature'lari olympus.su ile calisir, digerleri test.st5 ile
		Collection<String> tags = scenario.getSourceTagNames();
		OlympusPage.useOlympusSu = tags.contains("@LeadPortalFlow1a") || tags.contains("@LeadPortalFlow1b");
		setUp();
	}
	

	
	
	@After
	public void end(Scenario scenario)
	{
	    String softReport = null;
	    if (SoftAssertionCollector.hasErrors()) {
	        softReport = SoftAssertionCollector.getReport();
	        SoftAssertionCollector.clear();
	    }

	    byte[] screenshot;
	    String safeName = scenario.getName().replaceAll("[\\\\/:*?\"<>|]", "_");

	    if (scenario.isFailed() || softReport != null)
	    {
	        screenshot = takeScreenshot("failed/" + safeName);
	    }
	    else
	    {
	        screenshot = takeScreenshot("passed/" + safeName);
	    }

	    scenario.attach(screenshot, "image/png", scenario.getName());
	    tearDown();

	    if (softReport != null) {
	        throw new AssertionError(softReport);
	    }
	}
}
