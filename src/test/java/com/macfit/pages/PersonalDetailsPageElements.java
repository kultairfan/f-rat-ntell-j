package com.macfit.pages;

import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import com.macfit.testbase.BaseClass;

public class PersonalDetailsPageElements {
	
	@FindBy(id = "firstName")
	public WebElement firstName;
	
	@FindBy(id="pim.navbar.employeeName")
	public WebElement fullName;
	
	@FindBy(id = "employeeId")
	public WebElement employeeId;
	
	public PersonalDetailsPageElements()
	{
		PageFactory.initElements(BaseClass.driver, this);
	}
	

}
