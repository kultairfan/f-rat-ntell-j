Feature: WebForm

@Webform
Scenario: WebForm Generate

When I login to Olympus web with valid credentials
Then Navigate to web Form
Then I fill out to form
And Upload To Image