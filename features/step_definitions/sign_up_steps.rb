# Global variables
@user 			= nil
@skin 			= nil
@enemy 			= nil
@sword 			= nil
@landscape 	= nil


Given "I'm on the sign up page" do
	# Build the user
	@user = FactoryBot.build(:user)
	# Create default items
	@skin 			= FactoryBot.create(:default_skin)
	@enemy 			= FactoryBot.create(:default_enemy)
	@sword 			= FactoryBot.create(:default_sword)
	@landscape 	= FactoryBot.create(:default_landscape)
	visit new_user_registration_path
	expect(page).to have_css 'form#new_user.new_user' 
end

When "I fill in the right way all the fields" do	
	fill_in 'user_nickname' , with: @user.nickname
  fill_in 'user_name', with: @user.name
  fill_in 'user_last_name', with: @user.last_name
  fill_in 'user_email', with: @user.email 
  fill_in 'user_password' , with: @user.password
  fill_in 'user_password_confirmation', with: @user.password
end

When("I fill in the fields, no nick name") do
	fill_in 'user_nickname' , with: ''
  fill_in 'user_name', with: @user.name
  fill_in 'user_last_name', with: @user.last_name
  fill_in 'user_email', with: @user.email 
  fill_in 'user_password' , with: @user.password
  fill_in 'user_password_confirmation', with: @user.password
end

When("I fill in the fields, no name") do
	fill_in 'user_nickname' , with: @user.nickname
  fill_in 'user_name', with: ''
  fill_in 'user_last_name', with: @user.last_name
  fill_in 'user_email', with: @user.email 
  fill_in 'user_password' , with: @user.password
  fill_in 'user_password_confirmation', with: @user.password
end

When("I fill in the fields , no last name") do	
	fill_in 'user_nickname' , with: @user.nickname
  fill_in 'user_name', with: @user.name
  fill_in 'user_last_name', with: ''
  fill_in 'user_email', with: @user.email 
  fill_in 'user_password' , with: @user.password
  fill_in 'user_password_confirmation', with: @user.password
end

When("I fill in the fields ,no email") do
	fill_in 'user_nickname' , with: @user.nickname
  fill_in 'user_name', with: @user.name
  fill_in 'user_last_name', with: @user.last_name
  fill_in 'user_email', with: '' 
  fill_in 'user_password' , with: @user.password
  fill_in 'user_password_confirmation', with: @user.password
end

When("I fill in the field , no password") do	
	fill_in 'user_nickname' , with: @user.nickname
  fill_in 'user_name', with: @user.name
  fill_in 'user_last_name', with: @user.last_name
  fill_in 'user_email', with: @user.email 
  fill_in 'user_password' , with: ''
  fill_in 'user_password_confirmation', with: ''
end

When("I fill in the field , no password confirmation") do
	fill_in 'user_nickname' , with: @user.nickname
  fill_in 'user_name', with: @user.name
  fill_in 'user_last_name', with: @user.last_name
  fill_in 'user_email', with: @user.email 
  fill_in 'user_password' , with: @user.password
  fill_in 'user_password_confirmation', with: ''
end

When "I click on Sign Up" do
	find('input[name="commit"]').click
end

Then "I shuold see the successfull sign up message on homepage" do
	expect(page).to have_content 'Welcome! You have signed up successfully.'
end

Then("I shuold see the no nickname sign up message") do
  expect(page).to have_content "Nickname can't be blank"
end

Then("I shuold see the no name sign up message") do
  expect(page).to have_content "Name can't be blank"
end

Then("I shuold see the no last name sign up message") do
	expect(page).to have_content "Last name can't be blank"
end

Then("I shuold see the no email sign up message") do
  expect(page).to have_content "Email can't be blank"
end

Then("I shuold see the no password sign up message") do
  expect(page).to have_content "Password can't be blank"
end

Then("I shuold see the no password confirmation sign up message") do
  expect(page).to have_content "Password confirmation doesn't match Password"
end

Then("I shuold be redirected to sign up page") do
  expect(page).to have_css 'form#new_user.new_user' 
end

Then "The game data's instance is created" do
	expect(FactoryBot.build(:game_datum, user_id: $user)).to_not be_valid
end

Then("The user's items contains the default skins") do
  items = @user.items
  items.include?(@skin) && items.include?(@enemy) && items.include?(@sword) && items.include?(@landscape) 
end





