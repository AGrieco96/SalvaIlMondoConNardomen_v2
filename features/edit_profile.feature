Feature: Testing for profile editing

	Scenario: Change nickname
		Given I'm on edit profile page
		When I fill in the nickname field with new email
		And I fill in the current password field with password
		And I click on Update
		Then User's nickname should change

	Scenario: Change email
		Given I'm on edit profile page
		When I fill in the email field with new email
		And I fill in the current password field with password
		And I click on Update
		Then User's email should change

	Scenario: Change password
		Given I'm on edit profile page
		When I fill in the password field with new password
		And I fill in the password confimation with the same new password
		And I fill in the current password field with password
		And I click on Update
		Then User's password should change

	Scenario: Change avatar
		Given I'm on edit profile page
		When I upload with avatar
		And I fill in the current password field with password
		And I click on Update
		Then The user's avatar should change
		
	Scenario: Remove nickname
		Given I'm on edit profile page
		When I fill in the nickname field with empty string
		And I fill in the current password field with password
		And I click on Update
		Then I should see the no nickname message on edit page

	Scenario: Remove email
		Given I'm on edit profile page
		When I fill in the email field with empty string
		And I fill in the current password field with password
		And I click on Update
		Then I should see the no email message on edit page

	Scenario: Remove password
		Given I'm on edit profile page
		When I fill in the email field with empty string
		And I fill in the password field with empty password
		And I fill in the password confimation with empty password
		And I fill in the current password field with password
		And I click on Update
		Then I should see the no email message on edit page

	Scenario: Change password without password confimation
		Given I'm on edit profile page
		When I fill in the email field with empty string
		And I fill in the password field with new password
		And I fill in the password confimation with empty password
		And I fill in the current password field with password
		And I click on Update
		Then I should see the no password confirmation message on edit page

	Scenario: Submit changes without current password
		Given I'm on edit profile page
		When I fill in the email field with new email
		When I fill in the password field with new password
		And I fill in the password confimation with the same new password
		And I fill in the current password field with empty password
		And I click on Update
		Then I should see the no current password message on edit page

	Scenario: Submit changes with wrong current password
		Given I'm on edit profile page
		When I fill in the email field with new email
		When I fill in the password field with new password
		And I fill in the password confimation with the same new password
		And I fill in the current password field with wrong current password
		And I click on Update
		Then I should see the wrong current password message on edit page

	Scenario: Delete account
		Given I'm on edit profile page
		When I click on delete account
		Then my account shuold be delected
