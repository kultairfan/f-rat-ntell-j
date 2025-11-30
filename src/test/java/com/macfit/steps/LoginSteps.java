package com.macfit.steps;

import java.util.List;
import java.util.Map;

import org.junit.Assert;

import com.macfit.utils.CommonMethods;
import com.macfit.utils.ConfigsReader;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

public class LoginSteps extends CommonMethods{
	@Given("I navigated to HRM website")
	public void i_navigated_to_hrm_website() {
		
	    setUp();
	}

	@When("I enter a valid username")
	public void i_enter_a_valid_username() {
		   sendText(loginPage.username, ConfigsReader.getProperty("username"));

	}

	@When("I enter a valid password")
	public void i_enter_a_valid_password() {
		   sendText(loginPage.password, ConfigsReader.getProperty("password"));

	}

	@When("I click on the login button")
	public void i_click_on_the_login_button() {
	   click(loginPage.loginBtn);
	}

	@Then("I validate that I am logged in")
	public void i_validate_that_i_am_logged_in() {
	    String expected = "Jacqueline White";
	    
	    String actual = dashboardPage.accountName.getText();
	    
	    if(actual.equals(expected))
	    {
	    	System.out.println("Passed");
	    }
	    else
	    {
	    	System.out.println("Failed");
	    }
	}
	
	@Then ("I quit the browser")
	public void i_quit_the_browser()
	{
		tearDown();
	}

	@When("user enters username and password and clicks aon the login button")
	public void user_enters_username_and_password_and_clicks_aon_the_login_button(io.cucumber.datatable.DataTable dataTable) {
	    // Write code here that turns the phrase above into concrete actions
	    // For automatic transformation, change DataTable to one of
	    // E, List<E>, List<List<E>>, List<Map<K,V>>, Map<K,V> or
	    // Map<K, List<V>>. E,K,V must be a String, Integer, Float,
	    // Double, Byte, Short, Long, BigInteger or BigDecimal.
	    //
	    // For other transformations you can register a DataTableType.
	  List<Map<String, String>> map = dataTable.asMaps();
	  
	  System.out.println(dataTable);
	  
	  for(Map<String, String> el : map)
	  {
		  System.out.println("Logging in with: "+ el.get("username"));
		  System.out.println("Loggin in with: "+ el.get("password"));
		 
		  
		  sendText(loginPage.username, el.get("username"));
		  sendText(loginPage.password, el.get("password"));
		  
		  click(loginPage.loginBtn);
		  
		  String actualName = dashboardPage.accountName.getText();
		  
		  Assert.assertEquals("The account name does not match!",el.get("employeeName"), actualName);
		  
		  click(dashboardPage.accountMenu);
		  click(dashboardPage.logout);
	  }
	  
	  
	}

	
	
}
