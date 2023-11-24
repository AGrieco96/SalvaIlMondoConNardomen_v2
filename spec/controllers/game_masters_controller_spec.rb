require 'rails_helper'

RSpec.describe GameMastersController, type: :controller do

	describe 'GET #index' do
		# no logged user
		context 'When user is not logged in' do
			it 'redirect to login page' do
				get :index
				expect(response).to redirect_to '/login'
			end
		end
		# no gm user
		context 'When user is not game master' do
			before :each do
    		@request.env['devise.mapping'] = Devise.mappings[:user]
				@user = FactoryBot.create(:complete_user)
				sign_in @user
  		end
			it 'redirect to homepage' do
				get :index
				expect(response).to redirect_to '/'
			end
		end
		# gm user
		context 'When user is game master' do
			before :each do
    		@request.env['devise.mapping'] = Devise.mappings[:user]
				@user = FactoryBot.create(:game_master)
				FactoryBot.create_list(:complete_user , 10)
				sign_in @user
  		end
  		it 'populates @users array with users' do
  			get :index
  			users = assigns(:users)
  			users.each do |user|
  				expect(User.all).to include user
  			end
  		end
  		it 'populates @banned_users array with bans' do
  			get :index
  			banned_users = assigns(:banned_user)
  			banned_users.each do |user|
  				expect(User.all).to include user
  			end
  		end
  		it 'populates @request_ban array with bans request' do
  			get :index
  			request_ban = assigns(:request_ban)
  			request_ban.each do |user|
  				expect(User.all).to include user
  			end
  		end
  		it 'render the game master panel page' do
				get :index
				expect(response).to render_template :index
			end
  	end
	end


	describe 'POST #ban' do
		# no logged user
		context 'When user is not logged in' do
			it 'redirect to login page' do
				post :ban
				expect(response).to redirect_to '/login'
			end
		end
		# no gm user
		context 'When user is not game master' do
			before :each do
    		@request.env['devise.mapping'] = Devise.mappings[:user]
				@user = FactoryBot.create(:complete_user)
				sign_in @user
  		end
			it 'redirect to homepage' do
				post :ban
				expect(response).to redirect_to '/'
			end
		end
		# gm user
		context 'When user is game master' do
			before :each do
    		@request.env['devise.mapping'] = Devise.mappings[:user]
				@user = FactoryBot.create(:game_master)
				@user2 = FactoryBot.create(:complete_user)
				@days = Random.rand(10)

				sign_in @user
  		end
  		it 'assigns to @user a user' do
  			post :ban, params: { user: @user2.id, day_ban: @days, request: false}
  			expect(assigns(:user)).to eq @user2 
  		end
  		# it 'assigns to @days a date time' do
  		# 	post :ban, params: { user: @user2.id, day_ban: @days, request: false}
  		# 	expect(assigns(:days).class).to be_an_instance_of ActiveSupport::TimeWithZone
  		# end
  		it 'assigns to @request a boolean' do
  			post :ban, params: { user: @user2.id, day_ban: @days, request: false}
  			expect(assigns(:request)).to be nil
  		end
  		it 'create new ban instance' do
  			post :ban, params: { user: @user2.id, day_ban: @days, permanent_ban: false}
  			ban = Ban.find_by(user: User.find(@user2.id))
  			expect(Ban.all).to include ban
  		end
  		it 'redirects to master panel' do
  			post :ban, params: { user: @user2.id, day_ban: @days, request: false}
  			expect(response).to redirect_to '/masterpanel'
  		end
  	end

	end

end