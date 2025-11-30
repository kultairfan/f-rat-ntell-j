Feature: Login Functionality

  Scenario: Valid Login To HRM
    Given I navigated to HRM website
    When I enter a valid username
    And I enter a valid password
    And I click on the login button
    Then I validate that I am logged in
    And I quit the browser

  @Hw3
  Scenario Outline: Login using Outline and Examples Table
    
    Examples:

    When I enter valid "<username>" and "<password>"
    And I click on the login button
    Then verify that "<employeeName>" is displayed
      | username | password |  employeeName |
      | Nuraycan | sao45    | Nuray         |
      | InanSare | k1457    | Inanir        |

@Hw22
  Scenario: Login using Datatable
    When user enters username and password and clicks aon the login button
      | username   | password   |  employeeName |
      | arminarmin | Armin@2025 | Armin Arlert  |
      | ereneren   | Eren@2025  | Eren Yeager   |
