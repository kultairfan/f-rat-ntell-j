Feature: Search Employee
  
  @ela
 Scenario: : Search for Employee by ID

 	Given the user is logged in with valid credentials
 	And the user navigates to the employee list page
 	When the user enters valid employee ID
 	And clicks on the search button
 	Then the employee information is displayed
 	