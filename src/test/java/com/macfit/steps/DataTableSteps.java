package com.macfit.steps;

import java.util.List;
import java.util.Map;

import com.macfit.utils.CommonMethods;

import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

public class DataTableSteps extends CommonMethods {

	@When("I login to HRMs")
	public void i_login_to_hr_ms() {

	}

	@When("I want to add Employees")
	public void i_want_to_add_employees(DataTable dataTable) {
		// Write code here that turns the phrase above into concrete actions
		// For automatic transformation, change DataTable to one of
		// E, List<E>, List<List<E>>, List<Map<K,V>>, Map<K,V> or
		// Map<K, List<V>>. E,K,V must be a String, Integer, Float,
		// Double, Byte, Short, Long, BigInteger or BigDecimal.
		//
		// For other transformations you can register a DataTableType.

		List<Map<String, String>> listOfMaps = dataTable.asMaps();
		
		for(Map<String,String> map : listOfMaps)
		{
			System.out.println(map);
			System.out.println("-----------------");
			System.out.println("First Name: "+ map.get("FirstName"));
			System.out.println("Middle Name: "+ map.get("MiddleName"));
			System.out.println("LastName Name: "+ map.get("LastName"));
		}
	}

	@Then("I validate employee is added")
	public void i_validate_employee_is_added() {
		System.out.println("Validated Employee Added!");

	}

}
