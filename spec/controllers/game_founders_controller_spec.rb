require 'rails_helper'

@user = nil

RSpec.describe GameFoundersController, type: :controller do

	describe 'GET #index' do
		# no logged user
		context 'When user is not logged in' do
			it 'redirect to login page' do
				get :index
				expect(response).to redirect_to '/login'
			end
		end
		# no gm user
		context 'When user is not game founder' do
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
		context 'When user is game founder' do
			before :each do
    		@request.env['devise.mapping'] = Devise.mappings[:user]
				@user = FactoryBot.create(:game_founder)
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
  		it 'render the game founder panel page' do
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
		context 'When user is not game founder' do
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
		context 'When user is game founder' do
			before :each do
	  		@request.env['devise.mapping'] = Devise.mappings[:user]
				@user = FactoryBot.create(:game_founder)
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
  		it 'assigns to @permanent_ban a boolean' do
  			post :ban, params: { user: @user2.id, day_ban: @days, permanent_ban: false}
  			expect(assigns(:permanent_ban)).to be nil
  		end
  		it 'create new ban instance' do
  			post :ban, params: { user: @user2.id, day_ban: @days, permanent_ban: false}
  			ban = Ban.find_by(user: User.find(@user2.id))
  			expect(Ban.all).to include ban
  		end
  		it 'redirects to founder panel' do
  			post :ban, params: { user: @user2.id, day_ban: @days, request: false}
  			expect(response).to redirect_to '/founderpanel'
  		end
		end
	end

	describe 'POST #remove' do
		# no logged user
		context 'When user is not logged in' do
			it 'redirect to login page' do
				post :remove
				expect(response).to redirect_to '/login'
			end
		end
		# no gm user
		context 'When user is not game founder' do
			before :each do
	  		@request.env['devise.mapping'] = Devise.mappings[:user]
				@user = FactoryBot.create(:complete_user)
				sign_in @user
			end
			it 'redirect to homepage' do
				post :remove
				expect(response).to redirect_to '/'
			end
		end
		# gm user
		context 'When user is game founder' do
			before :each do
	  		@request.env['devise.mapping'] = Devise.mappings[:user]
				@user = FactoryBot.create(:game_founder)
				@user2 = FactoryBot.create(:complete_user)
				@ban = FactoryBot.create(:ban_temp , user: @user2)
				sign_in @user
			end
			it 'assigns to @user a ban instance' do
  			post :remove, params: { user: @user2.id }
  			expect(assigns(:user)).to eq @ban
  		end
  		it 'destroy ban instance' do
  			post :remove, params: { user: @user2.id }
  			expect(Ban.all).to_not include @ban
  		end
  		it 'redirects to founder panel' do
  			post :remove, params: { user: @user2.id }
  			expect(response).to redirect_to '/founderpanel'
  		end

		end
	end

	describe 'POST #promote' do
		# no logged user
		context 'When user is not logged in' do
			it 'redirect to login page' do
				post :promote
				expect(response).to redirect_to '/login'
			end
		end
		# no gm user
		context 'When user is not game founder' do
			before :each do
	  		@request.env['devise.mapping'] = Devise.mappings[:user]
				@user = FactoryBot.create(:complete_user)
				sign_in @user
			end
			it 'redirect to homepage' do
				post :promote
				expect(response).to redirect_to '/'
			end
		end
		# gm user
		context 'When user is game founder' do
			before :each do
	  		@request.env['devise.mapping'] = Devise.mappings[:user]
				@user = FactoryBot.create(:game_founder)
				@user2 = FactoryBot.create(:complete_user)
				sign_in @user
			end
			it 'assigns to @user a user' do
  			post :promote, params: { user: @user2.id}
  			expect(assigns(:user)).to eq @user2 
  		end
  		it 'change gm value to true' do
  			post :promote, params: { user: @user2.id}
  			@user2 = User.find(@user2.id)
  			expect(@user2.gm).to be true
  		end
  		it 'redirects to founder panel' do
  			post :promote, params: { user: @user2.id }
  			expect(response).to redirect_to '/founderpanel'
  		end
		end
	end

	describe 'POST #demote' do
		# no logged user
		context 'When user is not logged in' do
			it 'redirect to login page' do
				post :demote
				expect(response).to redirect_to '/login'
			end
		end
		# no gm user
		context 'When user is not game founder' do
			before :each do
	  		@request.env['devise.mapping'] = Devise.mappings[:user]
				@user = FactoryBot.create(:complete_user)
				sign_in @user
			end
			it 'redirect to homepage' do
				post :demote
				expect(response).to redirect_to '/'
			end
		end
		# gm user
		context 'When user is game founder' do
			before :each do
	  		@request.env['devise.mapping'] = Devise.mappings[:user]
				@user = FactoryBot.create(:game_founder)
				@user2 = FactoryBot.create(:complete_user)
				sign_in @user
			end
			it 'assigns to @user a user' do
  			post :demote, params: { user: @user2.id}
  			expect(assigns(:user)).to eq @user2 
  		end
  		it 'change gm value to false' do
  			post :demote, params: { user: @user2.id}
  			@user2 = User.find(@user2.id)
  			expect(@user2.gm).to be false
  		end
  		it 'redirects to founder panel' do
  			post :demote, params: { user: @user2.id }
  			expect(response).to redirect_to '/founderpanel'
  		end
		end
	end

	describe 'POST #approve' do
		# no logged user
		context 'When user is not logged in' do
			it 'redirect to login page' do
				post :approve
				expect(response).to redirect_to '/login'
			end
		end
		# no gm user
		context 'When user is not game founder' do
			before :each do
	  		@request.env['devise.mapping'] = Devise.mappings[:user]
				@user = FactoryBot.create(:complete_user)
				sign_in @user
			end
			it 'redirect to homepage' do
				post :approve
				expect(response).to redirect_to '/'
			end
		end
		# gm user
		context 'When user is game founder' do
			before :each do
	  		@request.env['devise.mapping'] = Devise.mappings[:user]
				@user = FactoryBot.create(:game_founder)
				@user2 = FactoryBot.create(:complete_user)
				@ban = FactoryBot.create(:ban_req , user: @user2)
				sign_in @user
			end
			it 'assigns to @user a ban instance' do
  			post :approve, params: { user: @user2.id , approve: "Ban"}
  			expect(assigns(:user)).to eq @ban
  		end
  		it 'assigns to @approve Ban' do
  			post :approve, params: { user: @user2.id , approve: "Ban"}
  			expect(assigns(:approve)).to eq "Ban"
  		end
  		it 'assigns to @approve Cancel' do
  			post :approve, params: { user: @user2.id , approve: "Cancel"}
  			expect(assigns(:approve)).to eq "Cancel"
  		end
  		it 'should permenently ban a user if approved == Ban' do
  			post :approve, params: { user: @user2.id , approve: "Ban"}
  			expect(Ban.all).to include @ban
  		end
  		it 'should cancel the instance of the ban a user if approved == Cancel' do
  			post :approve, params: { user: @user2.id , approve: "Cancel"}
  			expect(Ban.all).to_not include @ban
  		end

		end
	end

end
