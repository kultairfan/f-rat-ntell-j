Feature: Scenario with DataTable

@dataTable
  Scenario: Add Employee with DataTable
    When I login to HRMs
    And I want to add Employees
      | FirstName | MiddleName | LastName |
      | Ahmet     | Kenan       | Manıoglu |
      | May       |             | M.       |
      | Mehmed    | Sezgin      | Mehmed   |

      Then I validate employee is added
      