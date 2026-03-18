package com.macfit.steps;

import com.macfit.utils.CommonMethods;

import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.cucumber.java.Scenario;

public class Hooks extends CommonMethods{
	
	
	@Before
	public void start()
	{
		setUp();
	}
	

	
	
	@After
	public void end(Scenario scenario)
	{
	    byte[] screenshot;
	    
	    
	    String safeName = scenario.getName().replaceAll("[\\\\/:*?\"<>|]", "_");
	    
	    if(scenario.isFailed())
	    {
	        screenshot = takeScreenshot("failed/" + safeName);
	    }
	    else
	    {
	        screenshot = takeScreenshot("passed/" + safeName);    
	    }
	    
	    scenario.attach(screenshot, "image/png", scenario.getName());
	    tearDown();
	}
}
