require 'rails_helper'

RSpec.describe UsersController, type: :controller do

	# users#show
	describe 'GET #show' do
		# no logged in user
		context 'When user is not logged in' do
			it 'render login page' do
				get :show, params: { id: 1 }
				expect(response).to redirect_to '/login'
			end
		end
		# logged in user
		context 'When user is logged in' do
			before :each do
    		@request.env['devise.mapping'] = Devise.mappings[:user]
				@user = FactoryBot.create(:complete_user)
				sign_in @user
				@scores = FactoryBot.create_list(:score, 10, user: @user)
  		end
  		it 'assigns the user to a variable' do
  			get :show, params: { id: @user.id }
  			expect(assigns(:user)).to eq (@user)
  		end
  		it 'populates an array of scores' do
  			get :show, params: { id: @user.id }
  			@scores.each do |score| 
  				expect(assigns(:scores)).to include (score)
  			end
  		end
  		it 'render the show view' do
  			get :show, params: { id: @user.id }
  			expect(response).to render_template :show
  		end
		end
		# view another user profile
		context 'when a logged user view another user profile' do
			before :each do
    		@request.env['devise.mapping'] = Devise.mappings[:user]
				@user = FactoryBot.create(:complete_user)
				sign_in @user
				@other_user = FactoryBot.create(:complete_user)
				@scores = FactoryBot.create_list(:score, 10, user: @other_user)
  		end
  		it 'assigns the user to a variable' do
  			get :show, params: { id: @other_user.id }
  			expect(assigns(:user)).to eq (@other_user)
  		end
  		it 'populates an array of scores' do
  			get :show, params: { id: @other_user.id }
  			@scores.each do |score| 
  				expect(assigns(:scores)).to include (score)
  			end
  		end
  		it 'render the show view' do
  			get :show, params: { id: @other_user.id }
  			expect(response).to render_template :show
  		end
  	end
	end

	# users#search
	describe 'GET #search' do
		# no logged in user
		context 'When user is not logged in' do
			it 'render login page' do
				get :search
				expect(response).to redirect_to '/login'
			end
		end
		# logged in user
		context 'When user is logged in' do
			before :each do
    		@request.env['devise.mapping'] = Devise.mappings[:user]
				@user = FactoryBot.create(:complete_user)
				sign_in @user
				@users = []
				10.times do |n|
					@users << FactoryBot.create(:complete_user, nickname: 'user' + n.to_s )
				end
			end
			it 'redirect to home page without params' do
				get :search
				expect(response).to redirect_to '/'
			end
			it "assign nil to @user if param = '' " do
				get :search, params: { nick: '' }
				expect(assigns(:users)).to be_nil
			end 
			it 'assign the search result to @user if params is a valid nickname' do
				get :search, params: { nick: 'user' }
				@users.each do |user|
					expect(assigns(:users)).to include (user)
				end
			end
		end
	end

end
