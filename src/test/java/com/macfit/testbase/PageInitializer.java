package com.macfit.testbase;

import com.macfit.pages.AddEmployeePageElements;
import com.macfit.pages.AddWorkWeekDetailsPageElements;
import com.macfit.pages.CreateNewDisciplinaryCaseElements;
import com.macfit.pages.DashboardPageElements;
import com.macfit.pages.EmployeeListPageElements;
import com.macfit.pages.LoginPageElements;
import com.macfit.pages.PersonalDetailsPageElements;

public class PageInitializer extends BaseClass{
	
	public static LoginPageElements loginPage; 
	public static DashboardPageElements dashboardPage; 
	public static AddEmployeePageElements addEmployeePage; 
	public static PersonalDetailsPageElements personalDetailsPage; 
	public static EmployeeListPageElements employeeListPage;
	public static CreateNewDisciplinaryCaseElements createNewDisciplinaryCase;
	public static AddWorkWeekDetailsPageElements addWorkWeekDetailsPage;
	
	
	public static void initialize()
	{
		loginPage = new LoginPageElements();
		dashboardPage = new DashboardPageElements();
		addEmployeePage = new AddEmployeePageElements();
		personalDetailsPage = new PersonalDetailsPageElements();
		employeeListPage = new EmployeeListPageElements();
		createNewDisciplinaryCase = new CreateNewDisciplinaryCaseElements();
		addWorkWeekDetailsPage = new AddWorkWeekDetailsPageElements();
	}

}
