package com.macfit.pages;

import java.util.List;

import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import com.macfit.utils.CommonMethods;

public class CreateNewDisciplinaryCaseElements extends CommonMethods {
	@FindBy(id = "addEditDisciplineCase")
	public WebElement modalContainer;

	@FindBy(id = "noncoreIframe")
	public WebElement iFrame;

	@FindBy(id = "resultTable")
	public WebElement disListTable;

	@FindBy(xpath = "//a[@id='addItemBtn']")
	public WebElement addButton;

	@FindBy(xpath = "//form[@id='frmSaveDisciplinaryCase']//input[@id='addCase_employeeName_empName']")
	public WebElement employeeName;

	@FindBy(id = "addCase_caseName")
	public WebElement caseName;

	@FindBy(id = "addCase_caseName")
	public WebElement caseInput;

	@FindBy(id = "addCase_description")
	public WebElement description;

	@FindBy(id = "btnSave")
	public WebElement saveButton;

	@FindBy(id = "actionButtons")
	public WebElement actionButton;

	@FindBy(id = "btnBack")
	public WebElement cancelButton;

	@FindBy(id = "btnAction_closeDisciplinaryCase")
	public WebElement closeButton;

	@FindBy(id = "btnEdit")
	public WebElement editButton;

	@FindBy(xpath = "//div[contains(@class, 'modal-content customized-modal-content')]//label[text()]")
	public List<WebElement> labels;

	@FindBy(id = "addCase_employeeName_empName-error")
	public WebElement invalidEmpName;

	@FindBy(id = "addCase_caseName-error")
	public WebElement requiredError;

	@FindBy(xpath = "//table[@id='resultTable']//tbody/tr")
	public List<WebElement> disCaseTable;

	/// irfan added
	@FindBy(xpath = "//div[@id='menu-content']/ul/li[4]")
	public WebElement disciplineOnMenu;

	@FindBy(id = "menu_discipline_viewDisciplinaryCases")
	public WebElement disciplinaryCases;

	@FindBy(xpath = "//div[@id='primary-header']//span[1]")
	public WebElement disciplinarycasesTablePage;

	@FindBy(id ="searchModal")
	public WebElement filterButton;

	@FindBy(id = "searchForm")
	public WebElement searchForm;

	@FindBy(id = "DisciplinaryCaseSearch_empName_empName")
	public WebElement empName;
	
	@FindBy(xpath = "//div[@class='autoComplete-title']")
	public WebElement textSelect;

	@FindBy(id = "DisciplinaryCaseSearch_empName_empName-error")
	public WebElement invalidMessage;

	@FindBy(id = "searchBtn")
	public WebElement searchBtn;

	public CreateNewDisciplinaryCaseElements() {
		PageFactory.initElements(driver, this);
	}

}
