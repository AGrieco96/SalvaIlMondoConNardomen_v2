@user 			= nil
@good_item 	= nil
@bad_item		= nil

Given("I'm on store page") do
	# create the user
	@user   = FactoryBot.create(:complete_user)	
	@good_item = FactoryBot.create(:item, name: 'skin2', level: Random.rand(@user.level), price: Random.rand(@user.money))
	@bad_item = FactoryBot.create(:item, name: 'skin3', level: @user.level+Random.rand(5)+1, price: @user.money+Random.rand(100)+1)
	# login as user
	visit new_user_session_path
	fill_in 'user_email' , with: @user.email
	fill_in 'user_password', with: @user.password
	find('input[name="commit"]').click
	expect(page).to have_content "Signed in successfully."
	expect(page).to have_css 'div.home'
	visit store_path
	expect(page).to have_css 'section.item-section'
	expect(page).to have_css 'div.item-list'
end

When("I click buy on a valid object") do
	find('input#'+@good_item.name).click
end

When("I click buy on a invalid object") do
	find('input#'+@bad_item.name).click
end

Then("It should be in my items") do
	expect(page).to have_content @good_item.name+' purchased'
	expect(page).to have_css 'section.item-section'
	expect(page).to have_css 'div.item-list'
	@user.items.include?(@good_item)
end

Then("It not should be in my items") do
	expect(page).to have_content @bad_item.name+' not purchased. Check your level or your money'
	expect(page).to have_css 'section.item-section'
	expect(page).to have_css 'div.item-list'
	!@user.items.include?(@bad_item)
end