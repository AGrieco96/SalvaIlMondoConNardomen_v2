Feature: Testing for follow and unfollow a user

	Scenario: 	Follow a user
		Given 	I'm logged in
		And 	I'm on another unfollowed user's profile
		When 	I click on follow-unfollow button
		Then 	I follow a new user

	Scenario: 	Unfollow a user
		Given 	I'm logged in
		And 	I'm on another followed user's profile
		When 	I click on follow-unfollow button
		Then 	I stop following that user