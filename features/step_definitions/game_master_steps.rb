@master		=		nil
@user			=		nil
@ban 			= 	nil

Given("I'm a game master user") do
	@master = FactoryBot.create(:game_master)
	@user 	= FactoryBot.create(:complete_user)
	# login as game master
	visit new_user_session_path
	fill_in 'user_email' , with: @master.email
	fill_in 'user_password', with: @master.password
	find('input[name="commit"]').click
	expect(page).to have_content "Signed in successfully."
	expect(page).to have_css 'div.home'
	expect(page).to have_content 'Master panel'
end

Given("I am on master panel page") do
	visit masterpanel_path
	expect(page).to have_css 'div.users-list'
	expect(page).to have_css 'div.banned-list'
	expect(page).to have_css 'div.request-list'
end

When("I temporarily ban an user as master") do
	fill_in 'days', with: "2"
	find('input[name="commit"]').click
end

When("I request a permanent user ban") do
	check 'request'
	find('input[name="commit"]').click
end

Then("That user is banned by a master") do
	@ban = Ban.find_by(user: @user)
	Ban.all.include?(@ban)
end

Then("That user is in the requested ban") do
	@ban = Ban.find_by(user: @user)
	Ban.all.include?(@ban)
	@ban.request?
end