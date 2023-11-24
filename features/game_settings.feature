Feature: Testing game settings

	Scenario: Change skin
		Given I'm on game settings page
		When I change the skin
		And I click on Save changes
		Then My active skin should change

	Scenario: Change enemy
		Given I'm on game settings page
		When I change the enemy
		And I click on Save changes
		Then My active enemy should change

	Scenario: Change sword
		Given I'm on game settings page
		When I change the sword
		And I click on Save changes
		Then My active sword should change

	Scenario: Change landscape
		Given I'm on game settings page
		When I change the landscape
		And I click on Save changes
		Then My active landscape should change