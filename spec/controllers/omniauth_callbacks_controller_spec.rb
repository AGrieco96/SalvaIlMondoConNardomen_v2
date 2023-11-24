require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
	before do
		FactoryBot.create :complete_user
	end

	describe 'facebook' do
  	before do
    	request.env['devise.mapping'] = Devise.mappings[:user] 
    	request.env['omniauth.auth'] = facebook_hash
  	end
  	# new user
   	context 'with a new facebook user' do
    	it 'assign the new user to a variable' do
    		get :facebook
    		expect(assigns(:user)).to be_an_instance_of User
    	end
    	it 'redirect to edit profile page' do
    		get :facebook
    		expect(response).to redirect_to edit_user_registration_path(assigns(:user))
    	end
  	end
  	# existing user
  	context 'with an existing user' do
  		before do
  			@user = FactoryBot.create :complete_user
  			@user.update({
  				email: "stefano_fsdnitt_milani@tfbnw.net",
  				name: "Stefano",
  				last_name: "Milani",
  				provider: 'facebook',
  				uid: '115483839416294',
  				token: 'fb_token',
  				created_at: 5.minutes.ago
  				})
  		end
  		it 'assign the user to a variable' do
    		get :facebook
    		expect(assigns(:user)).to be_an_instance_of User
    	end
    	it 'redirect to home page' do
    		get :facebook
    		expect(response).to redirect_to root_path
    	end
  	end
	end

	describe 'twitter' do
  	before do
    	request.env['devise.mapping'] = Devise.mappings[:user] 
    	request.env['omniauth.auth'] = twitter_hash
  	end
  	# new user
   	context 'with a new twitter user' do
    	it 'assign the new user to a variable' do
    		get :twitter
    		expect(assigns(:user)).to be_an_instance_of User
    	end
    	it 'redirect to edit profile page' do
    		get :twitter
    		expect(response).to redirect_to edit_user_registration_path(assigns(:user))
    	end
  	end
  	# existing user
  	context 'with an existing user' do
  		before do
  			@user = FactoryBot.create :complete_user
  			@user.update({
  				email: "stefano_fsdnitt_milani@tfbnw.net",
  				name: "Stefano",
  				last_name: "Milani",
  				provider: 'facebook',
  				uid: 'tw_uid',
  				token: 'tw_token',
  				created_at: 5.minutes.ago
  				})
  		end
  		it 'assign the user to a variable' do
    		get :twitter
    		expect(assigns(:user)).to be_an_instance_of User
    	end
    	it 'redirect to home page' do
    		get :twitter
    		expect(response).to redirect_to root_path
    	end
  	end
	end
end