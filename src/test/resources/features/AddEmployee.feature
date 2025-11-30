Feature: Add Employee Feature
  I want to test Add Eployee Functionality

  Background: 
    Given the user is logged in with valid credentials
    And user navigates to AddEmployee page

  @AddEmployee
  Scenario: Add Employee first name last name
    When user enters employee first name and last name
    And user selects a location
    And user clicks on save button
    Then validate that employee is added succesfully

  @task22
  Scenario: Add Employee with parameterized first and last name
    When user enters employee first name "Cristiano" and last name "Ronaldo"
    And user selects a location
    And user clicks on save button
    Then validate that employee "Cristiano Ronaldo" is added successfully

  @scenarioOutline
  Scenario Outline: Adding multiple employees with scenario outline
    When user neters employee "<FirstName>" , "<MiddleName>" and "<LastName>"
    And user selects a location "<Location>"
    And user clicks on save button
    Then validate that "<FirstName>" and "<LastName>" is added successfully

    Examples: 
      | FirstName | MiddleName | LastName | Location                         |
      | Joe       | R          |  Bidon   | New York Sales Office            |
      | Donald    | J          | Trump    | Chinese Development Center       |
      | Barrack   | H          | Obama    | South African Development Center |

  @usingDataTable
  Scenario: Adding multiple employees with Datatable
    When user enters employee details and clicks on save and validates it is added
      | FirstName | MiddleName | LastName |
      | Adela     | A          | Gega     |
      | Tima      | N          | Fakoly   |
      | Emre      | U          | Oguz     |
