Feature: Store

	Scenario: Buy a valid item
		Given I'm on store page
		When I click buy on a valid object
		Then It should be in my items

	Scenario: Buy a invalid item
		Given I'm on store page
		When I click buy on a invalid object
		Then It not should be in my items