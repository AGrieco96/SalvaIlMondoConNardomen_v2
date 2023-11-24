Feature: Testing for sign up page

	Scenario: Sign up with valid information
		Given I'm on the sign up page
		When I fill in the right way all the fields
		And I click on Sign Up
		Then I shuold see the successfull sign up message on homepage
		And The game data's instance is created
		And The user's items contains the default skins

	Scenario: Sign up with invalid nickname
		Given I'm on the sign up page
		When I fill in the fields, no nick name
		And I click on Sign Up
		Then I shuold see the no nickname sign up message
		And I shuold be redirected to sign up page

	Scenario: Sign up with invalid name
		Given I'm on the sign up page
		When I fill in the fields, no name
		And I click on Sign Up
		Then I shuold see the no name sign up message
		And I shuold be redirected to sign up page

	Scenario: Sign up with invalid last name
		Given I'm on the sign up page
		When I fill in the fields , no last name
		And I click on Sign Up
		Then I shuold see the no last name sign up message
		And I shuold be redirected to sign up page

	Scenario: Sign up with invalid email
		Given I'm on the sign up page
		When I fill in the fields ,no email
		And I click on Sign Up
		Then I shuold see the no email sign up message
		And I shuold be redirected to sign up page

	Scenario: Sign up with invalid password
		Given I'm on the sign up page
		When I fill in the field , no password
		And I click on Sign Up
		Then I shuold see the no password sign up message
		And I shuold be redirected to sign up page

	Scenario: Sign up with invalid password confimation
		Given I'm on the sign up page
		When I fill in the field , no password confirmation
		And I click on Sign Up
		Then I shuold see the no password confirmation sign up message
		And I shuold be redirected to sign up page