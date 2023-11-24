# Global variables
@user 			= nil
@user2			= nil
@bad_nick 	= nil


Given("I'm a logged user and the search bar is available") do
	# create the user
	@user = FactoryBot.create(:complete_user)	
	# login as user
	visit new_user_session_path
	fill_in 'user_email' , with: @user.email
	fill_in 'user_password', with: @user.password
	find('input[name="commit"]').click
	expect(page).to have_content "Signed in successfully."
	expect(page).to have_css 'div.home'
	expect(page).to have_css 'form.search-form'
	expect(page).to have_css 'input#nick'
end

When("I fill the search box with a valid username") do
	@user2 = FactoryBot.create(:complete_user)
	fill_in 'nick', with: @user2.nickname
end

When("I fill the search box with an empty string") do
	fill_in 'nick', with: ''
end

When("I fill the search box with an invalid username") do
	@bad_nick = Faker::Internet.username
	fill_in 'nick', with: @bad_nick
end

When("I click on Search") do
  find('input.search-submit').click
end

When("I get search page without params") do
	visit search_path
end

Then("I should redirect to the search page") do
	expect(page).to have_css 'div.users-list'
	expect(page).to have_css 'ul.search-list'
end

Then("I should see the results") do
	expect(page).to have_content 'Result for " '+@user2.nickname+' " :'
	expect(page).to have_css 'li.user-list-elem'
	expect(page).to have_css 'a.user-link', text: @user2.nickname
end

Then("I should see the empty string message") do
  expect(page).to have_content 'Please provide a nickname'
  expect(page).to have_no_css 'li.user-list-elem'
  expect(page).to have_no_css 'a.user-link'
end

Then("I should see no result message") do
	expect(page).to have_content 'No result to display for "'+@bad_nick+'"'
  expect(page).to have_no_css 'li.user-list-elem'
  expect(page).to have_no_css 'a.user-link'
end

Then("I should redirect to the home page") do
	expect(page).to have_css 'div.home'
	expect(page).to have_css 'form.search-form'
	expect(page).to have_css 'input#nick'
end