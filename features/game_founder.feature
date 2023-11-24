Feature: Game Founder

	Scenario: Temporary ban an user
		Given 	I'm a game founder user
		And 	I am on founder panel page
		When 	I temporarily ban an user as founder
		Then 	That user is banned by a founder

	Scenario: Permanent ban request
		Given 	I'm a game founder user
		And 	I am on founder panel page
		When 	I permanently ban an user
		Then 	That user is permanent ban

	Scenario: Remove a ban
		Given 	I'm a game founder user
		And 	I am on founder panel page
		When 	I remove a ban
		Then 	That user is no longer banned

	Scenario: Accept a pemanent ban request
		Given 	I'm a game founder user
		And 	I am on founder panel page
		When 	I accept a permanent ban request
		Then 	That request is accepted

	Scenario: Cancel a pemanent ban request
		Given 	I'm a game founder user
		And 	I am on founder panel page
		When 	I cancel a permanent ban request
		Then 	That request is not accepted

	Scenario: Demote a game master
		Given 	I'm a game founder user
		And 	I am on founder panel page
		When 	I demote a game master
		Then 	That user is become a gamer

	Scenario: Promote a gamer
		Given 	I'm a game founder user
		And 	I am on founder panel page
		When 	I promote a gamer
		Then 	That user is become a game master

