# Global variables
@user   = nil
@user2  = nil

Given 	"I'm logged in" do 
	# create the user
	@user   = FactoryBot.create(:complete_user)	
	# login as user
	visit new_user_session_path
	fill_in 'user_email' , with: @user.email
	fill_in 'user_password', with: @user.password
	find('input[name="commit"]').click
	expect(page).to have_content "Signed in successfully."
	expect(page).to have_css 'div.home'
end

Given("I'm on another followed user's profile") do
	@user2  = FactoryBot.create(:complete_user)
  @user.following << @user2
	visit user_path(@user2)
	expect(page).to have_css("input", :class =>"unfollow")
end

Given("I'm on another unfollowed user's profile") do
	@user2  = FactoryBot.create(:complete_user)
	visit user_path(@user2)
  expect(page).to have_css("input", :class =>"follow")
end

When("I click on follow-unfollow button") do
	find('input[name="commit"]').click
end

Then("I follow a new user") do
	@user.following.include?(@user2)
end

Then("I stop following that user") do
	!@user.following.include?(@user2)
end