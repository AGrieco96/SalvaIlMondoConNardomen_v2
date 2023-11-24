@user 	= nil


Given("I'm on game settings page") do
	# create the user
	@user   = FactoryBot.create(:user_with_items)	
	# login as user
	visit new_user_session_path
	fill_in 'user_email' , with: @user.email
	fill_in 'user_password', with: @user.password
	find('input[name="commit"]').click
	expect(page).to have_content "Signed in successfully."
	expect(page).to have_css 'div.home'
	visit settings_path
	expect(page).to have_css 'select#skin'
	expect(page).to have_css 'select#enemy'
	expect(page).to have_css 'select#sword'
	expect(page).to have_css 'select#landscape'
end

When("I change the skin") do
	select 'skin2', from: 'skin'
end

When("I change the enemy") do
	select 'enemy2', from: 'enemy'
end

When("I change the sword") do
	select 'sword2', from: 'sword'
end

When("I change the landscape") do
	select 'landscape2', from: 'landscape'
end

When("I click on Save changes") do
	find('input.settings-submit').click
	@user = User.find_by(nickname: @user.nickname)
end

Then("My active skin should change") do
	expect(page).to have_content 'Changes saved successfull'
	expect(@user.skin.name).to_not eq Item.default_skin.name
	expect(@user.skin.name).to eq 'skin2'
end

Then("My active enemy should change") do
	expect(page).to have_content 'Changes saved successfull'
	expect(@user.enemy.name).to_not eq Item.default_enemy.name
	expect(@user.enemy.name).to eq 'enemy2'
end

Then("My active sword should change") do
	expect(page).to have_content 'Changes saved successfull'
	expect(@user.sword.name).to_not eq Item.default_sword.name
	expect(@user.sword.name).to eq 'sword2'
end

Then("My active landscape should change") do
	expect(page).to have_content 'Changes saved successfull'
	expect(@user.landscape.name).to_not eq Item.default_landscape.name
	expect(@user.landscape.name).to eq 'landscape2'
end