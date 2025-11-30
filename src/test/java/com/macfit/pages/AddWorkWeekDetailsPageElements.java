package com.macfit.pages;

import java.util.List;

import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import com.macfit.utils.CommonMethods;

public class AddWorkWeekDetailsPageElements extends CommonMethods {

	@FindBy(id = "menu_pim_viewMyDetails")
	public WebElement myInfo;

	@FindBy(id = "top-menu-trigger")
	public WebElement moreButton;

	@FindBy(xpath = "//div[@class='container col s12']/ul[3]/li[4]]")
	public WebElement moreDropDown;

	@FindBy(xpath = "//span[text()='Work Week']")
	public WebElement workWeek;

	@FindBy(id = "work_week_tab")
	public WebElement workWeekPage;

	@FindBy(xpath = "//div[@id='work_week_tab']/form//tbody/tr[2]/th")
	public List<WebElement> weekList;

	@FindBy(id = "change-employee-li")
	public WebElement switchToEmployee;

	@FindBy(id = "employee_name_quick_filter_value")
	public WebElement empNameOfSwitch;

	@FindBy(xpath = "//div[@class='angucomplete-row angucomplete-selected-row']")
	public WebElement empNameOfSwitchClick;

	@FindBy(xpath = "//i[@class='material-icons action-icon time-picker-open-icon'][1]")
	public WebElement shiftinClockMonday;

	@FindBy(xpath = "//div[@class='clockpicker-dial clockpicker-hours']//div[text()='9']")
	public WebElement hoursShiftIn;

	@FindBy(xpath = "//div[@class='clockpicker-dial clockpicker-hours']//div[text()='18']")
	public WebElement hoursShiftOut;

	@FindBy(xpath = "//button")
	public WebElement okButton;

	@FindBy(xpath = "//table/tbody/tr[3]/td[4]/div//i")
	public WebElement shiftOutClockMonday;
	@FindBy(xpath = "//table/tbody/tr[3]/td[4]//button")
	public WebElement shiftOutOkayButtonMonday;

	@FindBy(xpath = "//table/tbody/tr[3]/td[5]/div//i")
	public WebElement lunchInClockMonday;

	@FindBy(xpath = "//div[@class='clockpicker-dial clockpicker-hours']//div[text()='14']")
	public WebElement lunchInMonday;

	@FindBy(xpath = "//div[@class='clockpicker-dial clockpicker-minutes']//div[text()='10']")
	public WebElement luncInMin;

	@FindBy(xpath = "//table/tbody/tr[3]/td[5]//button")
	public WebElement lunchInOkayButtonMonday;

	@FindBy(xpath = "//table/tbody/tr[3]/td[6]/div//i")
	public WebElement lunchOutClockMonday;

	@FindBy(xpath = "//table/tbody/tr[3]/td[6]//button")
	public WebElement lunchOutOkayButtonMonday;

	@FindBy(xpath = "//div[@class='clockpicker-dial clockpicker-hours']//div[text()='15']")
	public WebElement lunchOutMonday;

	// Tuesday --> shift in
	@FindBy(xpath = "//table/tbody/tr[4]/td[3]//i")
	public WebElement shiftinClockTuesday;

	@FindBy(xpath = "//table/tbody/tr[4]//div[@class='clockpicker-dial clockpicker-hours']//div[text()='9']")
	public WebElement hoursShiftInTuesday;
	@FindBy(xpath = "//table/tbody/tr[4]//button")
	public WebElement shiftinOkButtonTuesday;

	// Tuesday --> shift out
	@FindBy(xpath = "//table/tbody/tr[4]/td[4]//i")
	public WebElement shiftOutClockTuesday;

	@FindBy(xpath = "//table/tbody/tr[4]/td[4]//div[@class='clockpicker-dial clockpicker-hours']//div[text()='18']")
	public WebElement hoursShiftOutTuesday;

	@FindBy(xpath = "//table/tbody/tr[4]/td[4]//button")
	public WebElement shiftOutOkButtonTuesday;

	// Tuesday--lunch in

	@FindBy(xpath = "//table/tbody/tr[4]/td[5]//i")
	public WebElement lunchInClockTuesday;

	@FindBy(xpath = "//table/tbody/tr[4]/td[5]//div[@class='clockpicker-dial clockpicker-hours']//div[text()='14']")
	public WebElement lunchInTuesday;

	@FindBy(xpath = "//table/tbody/tr[4]/td[5]//button")
	public WebElement lunchInOkayButtonTuesday;

	// Tuesday -- lunch out
	@FindBy(xpath = "//table/tbody/tr[4]/td[6]//i")
	public WebElement lunchOutClockTuesday;
	@FindBy(xpath = "//table/tbody/tr[4]/td[6]//div[@class='clockpicker-dial clockpicker-hours']//div[text()='15']")
	public WebElement lunchOutTuesday;
	@FindBy(xpath = "//table/tbody/tr[4]/td[6]//button")
	public WebElement lunchOutOkayButtonTuesday;

	// Wednesday

	@FindBy(xpath = "//table/tbody/tr[5]/td[3]//i")
	public WebElement shiftinClockWednesday;

	@FindBy(xpath = "//table/tbody/tr[5]//div[@class='clockpicker-dial clockpicker-hours']//div[text()='9']")
	public WebElement hoursShiftInWednesday;
	@FindBy(xpath = "//table/tbody/tr[5]//button")
	public WebElement shiftinOkButtonWednesday;

	// Wednesday --> shift out
	@FindBy(xpath = "//table/tbody/tr[5]/td[4]//i")
	public WebElement shiftOutClockWednesday;

	@FindBy(xpath = "//table/tbody/tr[5]/td[4]//div[@class='clockpicker-dial clockpicker-hours']//div[text()='18']")
	public WebElement hoursShiftOutWednesday;

	@FindBy(xpath = "//table/tbody/tr[5]/td[4]//button")
	public WebElement shiftOutOkButtonWednesday;

	// Wednesday--lunch in

	@FindBy(xpath = "//table/tbody/tr[5]/td[5]//i")
	public WebElement lunchInClockWednesday;

	@FindBy(xpath = "//table/tbody/tr[5]/td[5]//div[@class='clockpicker-dial clockpicker-hours']//div[text()='14']")
	public WebElement lunchInWednesday;

	@FindBy(xpath = "//table/tbody/tr[5]/td[5]//button")
	public WebElement lunchInOkayButtonWednesday;

	// Wednesday-- lunch out
	@FindBy(xpath = "//table/tbody/tr[5]/td[6]//i")
	public WebElement lunchOutClockWednesday;
	@FindBy(xpath = "//table/tbody/tr[5]/td[6]//div[@class='clockpicker-dial clockpicker-hours']//div[text()='15']")
	public WebElement lunchOutWednesday;
	@FindBy(xpath = "//table/tbody/tr[5]/td[6]//button")
	public WebElement lunchOutOkayButtonWednesday;

	// Thursday

	@FindBy(xpath = "//table/tbody/tr[6]/td[3]//i")
	public WebElement shiftinClockThursday;

	@FindBy(xpath = "//table/tbody/tr[6]//div[@class='clockpicker-dial clockpicker-hours']//div[text()='9']")
	public WebElement hoursShiftInThursday;
	@FindBy(xpath = "//table/tbody/tr[6]//button")
	public WebElement shiftinOkButtonThursday;

	// Thursday--> shift out
	@FindBy(xpath = "//table/tbody/tr[6]/td[4]//i")
	public WebElement shiftOutClockThursday;

	@FindBy(xpath = "//table/tbody/tr[6]/td[4]//div[@class='clockpicker-dial clockpicker-hours']//div[text()='18']")
	public WebElement hoursShiftOutThursday;

	@FindBy(xpath = "//table/tbody/tr[6]/td[4]//button")
	public WebElement shiftOutOkButtonThursday;

	// Thursday--lunch in

	@FindBy(xpath = "//table/tbody/tr[6]/td[5]//i")
	public WebElement lunchInClockThursday;

	@FindBy(xpath = "//table/tbody/tr[6]/td[5]//div[@class='clockpicker-dial clockpicker-hours']//div[text()='14']")
	public WebElement lunchInThursday;

	@FindBy(xpath = "//table/tbody/tr[6]/td[5]//button")
	public WebElement lunchInOkayButtonThursday;

	// Thursday-- lunch out
	@FindBy(xpath = "//table/tbody/tr[6]/td[6]//i")
	public WebElement lunchOutClockThursday;
	@FindBy(xpath = "//table/tbody/tr[6]/td[6]//div[@class='clockpicker-dial clockpicker-hours']//div[text()='15']")
	public WebElement lunchOutThursday;
	@FindBy(xpath = "//table/tbody/tr[6]/td[6]//button")
	public WebElement lunchOutOkayButtonThursday;

	// Friday

	@FindBy(xpath = "//table/tbody/tr[7]/td[3]//i")
	public WebElement shiftinClockFriday;

	@FindBy(xpath = "//table/tbody/tr[7]//div[@class='clockpicker-dial clockpicker-hours']//div[text()='9']")
	public WebElement hoursShiftInFriday;
	@FindBy(xpath = "//table/tbody/tr[7]//button")
	public WebElement shiftinOkButtonFriday;

	// Friday--> shift out
	@FindBy(xpath = "//table/tbody/tr[7]/td[4]//i")
	public WebElement shiftOutClockFriday;

	@FindBy(xpath = "//table/tbody/tr[7]/td[4]//div[@class='clockpicker-dial clockpicker-hours']//div[text()='18']")
	public WebElement hoursShiftOutFriday;

	@FindBy(xpath = "//table/tbody/tr[7]/td[4]//button")
	public WebElement shiftOutOkButtonFriday;

	// Thursday--lunch in

	@FindBy(xpath = "//table/tbody/tr[7]/td[5]//i")
	public WebElement lunchInClockFriday;

	@FindBy(xpath = "//table/tbody/tr[7]/td[5]//div[@class='clockpicker-dial clockpicker-hours']//div[text()='14']")
	public WebElement lunchInFriday;

	@FindBy(xpath = "//table/tbody/tr[7]/td[5]//button")
	public WebElement lunchInOkayButtonFriday;

	// Thursday-- lunch out
	@FindBy(xpath = "//table/tbody/tr[7]/td[6]//i")
	public WebElement lunchOutClockFriday;
	@FindBy(xpath = "//table/tbody/tr[7]/td[6]//div[@class='clockpicker-dial clockpicker-hours']//div[text()='15']")
	public WebElement lunchOutFriday;
	@FindBy(xpath = "//table/tbody/tr[7]/td[6]//button")
	public WebElement lunchOutOkayButtonFriday;

	@FindBy(xpath = "//div[@class='right-align form-buttons']//a")
	public WebElement saveButton;

	public AddWorkWeekDetailsPageElements() {
		PageFactory.initElements(driver, this);
	}
}
