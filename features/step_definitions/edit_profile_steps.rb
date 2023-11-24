@user 					= nil
@new_email 			= nil
@new_nick				= nil
@new_password 	= nil
@old_avatar			= nil

Given("I'm on edit profile page") do
	# create the user
	@user   = FactoryBot.create(:complete_user)	
	# login as user
	visit new_user_session_path
	fill_in 'user_email' , with: @user.email
	fill_in 'user_password', with: @user.password
	find('input[name="commit"]').click
	expect(page).to have_content "Signed in successfully."
	expect(page).to have_css 'div.home'
	# got to edit profile
	visit edit_user_registration_path
	expect(page).to have_css 'form#edit_user.edit_user'
end

When("I fill in the nickname field with new email") do
	@new_nick = Faker::Internet.username
	fill_in 'user_nickname', with: @new_nick
end

When("I fill in the nickname field with empty string") do
	fill_in 'user_nickname',with: ''
end

When("I fill in the email field with new email") do
	fill_in 'user_email',with: ''
	@new_email = Faker::Internet.email
	fill_in 'user_email',with: @new_email
end

When("I fill in the email field with empty string") do
	fill_in 'user_email',with: ''
end

When("I fill in the password field with new password") do
	@new_password = Faker::Internet.password
	fill_in 'user_password',with: @new_password
end

When("I fill in the password field with empty password") do
	fill_in 'user_password',with: ''
end

When("I fill in the password confimation with the same new password") do
	fill_in 'user_password_confirmation',with: @new_password
end

When("I fill in the password confimation with empty password") do
	fill_in 'user_password_confirmation',with: ''
end

When("I fill in the current password field with password") do
	fill_in 'user_current_password',with: @user.password
end

When("I fill in the current password field with empty password") do
	fill_in 'user_current_password',with: ''
end

When("I fill in the current password field with wrong current password") do
	fill_in 'user_current_password',with: Faker::Internet.password
end

When("I upload with avatar") do
	attach_file 'user_avatar', './features/assets/Kurama.jpg'
	@old_avatar = @user.avatar
end

When("I click on Update") do
	find('input.update-submit').click
	@user = User.find_by(name: @user.name)
end

When("I click on delete account") do
	find('input[value="Cancel my account"]').click
end

Then("User's nickname should change") do
	expect(page).to have_content 'Your account has been updated successfully.'
	expect(@user.nickname).to eq @new_nick
end

Then("User's email should change") do
	expect(page).to have_content 'Your account has been updated successfully.'
	expect(@user.email).to eq @new_email
end

Then("User's password should change") do
  expect(page).to have_content 'Your account has been updated successfully.'
  click_on 'Logout'
  visit new_user_session_path
  fill_in 'user_email' , with: @user.email
	fill_in 'user_password', with: @new_password
	find('input[name="commit"]').click
	expect(page).to have_content "Signed in successfully."
	expect(page).to have_css 'div.home'
end

Then("The user's avatar should change") do
	expect(@user.avatar).to_not eq @old_avatar
end

Then("I should see the no nickname message on edit page") do
	expect(page).to have_content "Nickname can't be blank"
	expect(page).to have_css 'form#edit_user.edit_user'
end

Then("I should see the no email message on edit page") do
	expect(page).to have_content "Email can't be blank"
	expect(page).to have_css 'form#edit_user.edit_user'
end

Then("I should see the no password confirmation message on edit page") do
	expect(page).to have_content "Password confirmation doesn't match Password"
	expect(page).to have_css 'form#edit_user.edit_user'
end

Then("I should see the no current password message on edit page") do
	expect(page).to have_content "Current password can't be blank"
	expect(page).to have_css 'form#edit_user.edit_user'
end

Then("I should see the wrong current password message on edit page") do  
	expect(page).to have_content "Current password is invalid"
	expect(page).to have_css 'form#edit_user.edit_user'
end

Then("my account shuold be delected") do
	expect(page).to have_content "Bye! Your account has been successfully cancelled. We hope to see you again soon."
	expect(page).to have_css 'div.home'
	User.find_by(name: @user.name).nil?
end