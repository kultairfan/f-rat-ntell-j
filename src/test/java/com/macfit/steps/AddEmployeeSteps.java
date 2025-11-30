package com.macfit.steps;

import java.util.List;
import java.util.Map;

import org.junit.Assert;

import com.macfit.utils.CommonMethods;

import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;


public class AddEmployeeSteps extends CommonMethods{
	@Given("user navigates to AddEmployee page")
	public void user_navigates_to_add_emoloyee_page() {
		
		click(dashboardPage.PIM);
		click(dashboardPage.addEmployeeLink);
		
	}

	@When("user enters employee first name and last name")
	public void user_enters_employee_first_name_and_last_name() {
		sendText(addEmployeePage.firstName, "Lionel");
		sendText(addEmployeePage.lastName, "Messi");
	}

	@When("user selects a location")
	public void user_selects_a_location() {
		selectDropdown(addEmployeePage.location, "New York Sales Office");
		
		
	}

	@When("user clicks on save button")
	public void user_clicks_on_save_button() {
		click(addEmployeePage.saveButton);
		
	}

	@Then("validate that employee is added succesfully")
	public void validate_that_employee_is_added_succesfully() {
		
		waitForVisibility(personalDetailsPage.fullName);
		
		String expected = "Lionel Messi";
		
		String actual = personalDetailsPage.fullName.getText();
		
		Assert.assertEquals("The employee name does Not Match!",expected, actual);
		
	}
	
	
	@When("user enters employee first name {string} and last name {string}")
	public void user_enters_employee_first_name_and_last_name(String firstName, String lastName) {
	   sendText(addEmployeePage.firstName, firstName);
	   sendText(addEmployeePage.lastName, lastName);
	}
	@Then("validate that employee {string} is added successfully")
	public void validate_that_employee_is_added_successfully(String fullName) {
	    
		waitForVisibility(personalDetailsPage.fullName);
		
		String expected = fullName;
		
		String actual = personalDetailsPage.fullName.getText();
		
		Assert.assertEquals("The employee name does Not Match!",expected, actual);
		
	}
	
	//Scenario outline
	@When("user neters employee {string} , {string} and {string}")
	public void user_neters_employee_and(String FirstName, String MiddleName, String LastName) {
	    sendText(addEmployeePage.firstName, FirstName);
	    sendText(addEmployeePage.middleName, MiddleName);
	    sendText(addEmployeePage.lastName, LastName);
	}
	@When("user selects a location {string}")
	public void user_selects_a_location(String Location) {
		
		selectDropdown(addEmployeePage.location, Location);
	    
	}
	@Then("validate that {string} and {string} is added successfully")
	public void validate_that_and_is_added_successfully(String FirstName, String LastName) {
	   
		waitForVisibility(personalDetailsPage.fullName);
		
		String expectedName = FirstName + " " + LastName;
		
		String actualName = personalDetailsPage.fullName.getText();
		
		Assert.assertEquals("The employee name does Not Match!",expectedName, actualName);
	}

	// Using datatable
	
	@When("user enters employee details and clicks on save and validates it is added")
	public void user_enters_employee_details_and_clicks_on_save_and_validates_it_is_added(DataTable dataTable) {
	    // Write code here that turns the phrase above into concrete actions
	    // For automatic transformation, change DataTable to one of
	    // E, List<E>, List<List<E>>, List<Map<K,V>>, Map<K,V> or
	    // Map<K, List<V>>. E,K,V must be a String, Integer, Float,
	    // Double, Byte, Short, Long, BigInteger or BigDecimal.
	    //
	    // For other transformations you can register a DataTableType.
	   
		List<Map<String,String>> map = dataTable.asMaps();
		
		for(Map<String,String> el : map)
		{
			System.out.println(el);
			
			String fName = el.get("FirstName");
			String mName = el.get("MiddleName");
			String lName = el.get("LastName");
			
			sendText(addEmployeePage.firstName, fName);
			sendText(addEmployeePage.middleName, mName);
			sendText(addEmployeePage.lastName, lName);
			
			
			selectDropdown(addEmployeePage.location, "New York Sales Office");
			wait(1);
			
			click(addEmployeePage.saveButton);
			
			waitForVisibility(personalDetailsPage.fullName);
			
			String expectedName = fName + " "+ lName;
			String actualName = personalDetailsPage.fullName.getText();
			
			
			Assert.assertEquals("The employee name does Not Match!",expectedName, actualName);
			
			wait(1);
			click(dashboardPage.addEmployeeLink);
		}
		
	}




}
