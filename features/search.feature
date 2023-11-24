Feature: Testing search bar

	Scenario: Search an existing user
		Given I'm a logged user and the search bar is available
		When I fill the search box with a valid username
		And I click on Search
		Then I should redirect to the search page
		And I should see the results

	Scenario: Search an empty string 
		Given I'm a logged user and the search bar is available
		When I fill the search box with an empty string
		And I click on Search
		Then I should redirect to the search page
		And I should see the empty string message

	Scenario: Search a not existing username
		Given I'm a logged user and the search bar is available
		When I fill the search box with an invalid username
		And I click on Search
		Then I should redirect to the search page
		And I should see no result message

	Scenario: Get search page without params
		Given I'm a logged user and the search bar is available
		When I get search page without params
		Then I should redirect to the home page