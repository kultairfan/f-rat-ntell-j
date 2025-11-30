package com.macfit.pages;

import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import com.macfit.utils.CommonMethods;

public class EmployeeListPageElements extends CommonMethods{
	@FindBy(id ="employee_name_quick_filter_employee_list_value")
	public WebElement searchBox;
	
	@FindBy(id = "quick_search_icon")
	public WebElement searchBtn;
	
	
	
	
	
	
	
	
	public EmployeeListPageElements()
	{
		PageFactory.initElements(driver, this);
	}

}
