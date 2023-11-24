# Global variables
@user 	= nil
@user2 	= nil

Given("I'm on login page") do
	# Create users
	@user 	= FactoryBot.create(:complete_user)
	@user2 	= FactoryBot.create(:complete_user)
  visit new_user_session_path
  expect(page).to have_css 'form#new_user.new_user'
end

When("I fill the email field") do
	fill_in 'user_email' , with: @user.email
end

When("I fill the password field") do
 fill_in 'user_password' , with: @user.password
end

When("I fill the email field with an invalid email") do
  fill_in 'user_email', with: @user2.email
end

When("I fill the password field with invalid password") do
  fill_in 'user_password', with: @user2.password
end

When("I click on login button") do
  find('input[name="commit"]').click
end

Then("I shuold see the successfull login message on the homepage") do
  expect(page).to have_content "Signed in successfully."
  expect(page).to have_css 'div.home'
end

Then("I shuold see the unsuccessfull login message and be redirected to login page") do
  expect(page).to have_content "Invalid Email or password."
  expect(page).to have_css 'form#new_user.new_user'
end