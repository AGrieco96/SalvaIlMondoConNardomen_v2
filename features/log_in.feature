Feature: Testing for sign up page

	Scenario: Log in with valid information
		Given I'm on login page
		When I fill the email field
		And I fill the password field
		And I click on login button
		Then I shuold see the successfull login message on the homepage

	Scenario: Log in with no email
		Given I'm on login page
		When I fill the password field
		And I click on login button
		Then I shuold see the unsuccessfull login message and be redirected to login page

	Scenario: Log in with no password
		Given I'm on login page
		When I fill the email field
		And I click on login button
		Then I shuold see the unsuccessfull login message and be redirected to login page

	Scenario: Log in with wrong email
		Given I'm on login page
		When I fill the email field with an invalid email
		And I fill the password field
		And I click on login button
		Then I shuold see the unsuccessfull login message and be redirected to login page

	Scenario: Log in with wrong password
		Given I'm on login page
		When I fill the email field
		And I fill the password field with invalid password
		And I click on login button
		Then I shuold see the unsuccessfull login message and be redirected to login page