@founder		=		nil
@master			=		nil
@user				=		nil
@user2 			= 	nil
@req_user	 	= 	nil
@ban 				= 	nil
@req 				= 	nil
@ban2 			= 	nil

Given("I'm a game founder user") do
	@founder 	= FactoryBot.create(:game_founder)
	@master 	= FactoryBot.create(:game_master)
	@user 		= FactoryBot.create(:complete_user)
	@user2 		= FactoryBot.create(:complete_user)
	@req_user = FactoryBot.create(:complete_user)
	@req 			= FactoryBot.create(:ban_req, user: @req_user)
	@ban2 		= FactoryBot.create(:ban_temp, user: @user2)
	# login as game founder
	visit new_user_session_path
	fill_in 'user_email' , with: @founder.email
	fill_in 'user_password', with: @founder.password
	find('input[name="commit"]').click
	expect(page).to have_content "Signed in successfully."
	expect(page).to have_css 'div.home'
	expect(page).to have_content 'Founder panel'
end

Given("I am on founder panel page") do
	visit founderpanel_path
	expect(page).to have_css 'div.users-list'
	expect(page).to have_css 'div.banned-list'
	expect(page).to have_css 'div.request-list'
end

When("I temporarily ban an user as founder") do
	str = @user.id.to_s+'-days'
	fill_in str, with: "2"
	name = "commit-ban#{@user.id}"
	str = 'input[name="'+name+'"]'
	find(str).click
end

When("I permanently ban an user") do
	str = @user.id.to_s+'-permanent'
	check str
	name = "commit-ban#{@user.id}"
	str = 'input[name="'+name+'"]'
	find(str).click
end

When("I accept a permanent ban request") do
	choose 'approve_Ban'
	name = "commit-req#{@req.id}"
	str = 'input[name="'+name+'"]'
	find(str).click
end

When("I cancel a permanent ban request") do
  choose 'approve_Cancel'
	name = "commit-req#{@req.id}"
	str = 'input[name="'+name+'"]'
	find(str).click
end

When("I remove a ban") do
	name = "commit-remove#{@ban2.id}"
	str = 'input[name="'+name+'"]'
	find(str).click
end

When("I demote a game master") do
	name = "demote#{@master.id}"
	str = 'input[name="'+name+'"]'
	find(str).click
end

When("I promote a gamer") do
	name = "promote#{@user.id}"
	str = 'input[name="'+name+'"]'
	find(str).click
end

Then("That user is banned by a founder") do
	@ban = Ban.find_by(user: @user)
	Ban.all.include?(@ban)
end

Then("That user is permanent ban") do
	@ban = Ban.find_by(user: @user)
	Ban.all.include?(@ban)
	@ban.day_ban > 100.years.from_now
end

Then("That request is accepted") do
	@req = Ban.find_by(user: @req_user)
	Ban.all.include?(@req)
	@req.day_ban > 100.years.from_now
end

Then("That request is not accepted") do
  Ban.find_by(user: @req_user).nil?
end

Then("That user is no longer banned") do
	Ban.find_by(user: @user2).nil?
end

Then("That user is become a gamer") do
	@master = User.find(@master.id)
	!@master.gm?
end

Then("That user is become a game master") do
	@user = User.find(@master.id)
	@user.gm?
end