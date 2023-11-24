Feature: Game Master

	Scenario: Temporary ban an user
		Given 	I'm a game master user
		And 	I am on master panel page
		When 	I temporarily ban an user as master
		Then 	That user is banned by a master

	Scenario: Send a permanent ban request
		Given 	I'm a game master user
		And 	I am on master panel page
		When 	I request a permanent user ban
		Then 	That user is in the requested ban