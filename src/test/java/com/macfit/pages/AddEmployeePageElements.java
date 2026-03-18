package com.macfit.pages;

import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import com.macfit.testbase.BaseClass;

public class AddEmployeePageElements {

	@FindBy(id = "first-name-box")
	public WebElement firstName;

	@FindBy(id = "last-name-box")
	public WebElement lastName;

	@FindBy(id = "middle-name-box")
	public WebElement middleName;

	@FindBy(id = "employeeId")
	public WebElement employeeId;

	@FindBy(id = "location")
	public WebElement location;

	@FindBy(xpath = "//div[@class='custom-control custom-switch']")
	public WebElement loginDetailsToggle;

	@FindBy(id = "username")
	public WebElement username;

	@FindBy(id = "password")
	public WebElement password;

	@FindBy(id = "confirmPassword")
	public WebElement confirmPassword;

	@FindBy(id = "modal-save-button")
	public WebElement saveButton;

	public AddEmployeePageElements() {
		PageFactory.initElements(BaseClass.driver, this);
	}

}
