package com.macfit.pages;

import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import com.macfit.testbase.BaseClass;

public class DashboardPageElements {
	
	@FindBy(id="ohrm-small-logo")
	public WebElement logo;
	
	@FindBy(id="account-name")
	public WebElement accountName;
	
	@FindBy(id="menu_pim_viewPimModule")
	public WebElement PIM;
	
	@FindBy(linkText = "Add Employee")
	public WebElement addEmployeeLink;
	
	@FindBy(id = "menu_pim_viewEmployeeList")
	public WebElement employeeList;
	
	@FindBy(id = "account-job")
	public WebElement accountMenu;
	
	@FindBy(id = "logoutLink")
	public WebElement logout;
	 
	public DashboardPageElements()
	{
		PageFactory.initElements(BaseClass.driver, this);
	}

}
