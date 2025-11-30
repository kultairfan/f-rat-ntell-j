package com.macfit.steps;

import com.macfit.utils.CommonMethods;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

public class SearchEmployeeSteps extends CommonMethods{
	
	@Given("the user is logged in with valid credentials")
	public void the_user_is_logged_in_with_valid_credentials() {
	   loginPage.adminLogin();
	}
	@Given("the user navigates to the employee list page")
	public void the_user_navigates_to_the_employee_list_page() {
	    click(dashboardPage.PIM);
	    click(dashboardPage.employeeList);
	}
	@When("the user enters valid employee ID")
	public void the_user_enters_valid_employee_id() {
		sendText(employeeListPage.searchBox, "0044");
	   
	}
	@When("clicks on the search button")
	public void clicks_on_the_search_button() {
		click(employeeListPage.searchBtn);
	   
	}
	@Then("the employee information is displayed")
	public void the_employee_information_is_displayed() {
		System.out.println("Yes it is I see it there");
		wait(5);
	    
	}


}
