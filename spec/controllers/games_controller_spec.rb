require 'rails_helper'

RSpec.describe GamesController, type: :controller do
	# games#settings
	describe 'GET #settings' do
		# no logged in user
		context 'When user is not logged in' do
			it 'render login page' do
				get :settings
				expect(response).to redirect_to '/login'
			end
		end
		# logged in user
		context 'When user is logged in' do
			before :each do
    		@request.env['devise.mapping'] = Devise.mappings[:user]
				@user = FactoryBot.create(:user_with_items)
				sign_in @user
  		end
  		it 'assign current user to a variable' do
  			get :settings
  			expect(assigns(:user)).to eq @user
  		end
  		it "render the game's settings page" do
  			get :settings
  			expect(response).to render_template :settings
  		end
  	end
	end

	# games#change_settings
	describe 'POST #change_settings' do
		# no logged in user
		context 'When user is not logged in' do
			it 'render login page' do
				post :change_settings
				expect(response).to redirect_to '/login'
			end
		end
		# logged in user
		context 'When user is logged in' do
			before :each do
    		@request.env['devise.mapping'] = Devise.mappings[:user]
				@user = FactoryBot.create(:user_with_items)
				@skin = @user.items.find_by(name: 'skin2')
				@enemy = @user.items.find_by(name: 'enemy2')
				@sword = @user.items.find_by(name: 'sword2')
				@landscape = @user.items.find_by(name: 'landscape2')
				sign_in @user	
  		end
  		it 'assing the choosen skin to a variable' do
  			post :change_settings, params: { skin: @skin.id , enemy: @enemy.id , sword: @sword.id , landscape: @landscape.id }
  			expect(assigns(:skin)).to eq @skin
  		end
  		it 'assing the choosen enemy to a variable' do
  			post :change_settings, params: { skin: @skin.id , enemy: @enemy.id , sword: @sword.id , landscape: @landscape.id }
  			expect(assigns(:enemy)).to eq @enemy
  		end
  		it 'assing the choosen sword to a variable' do
  			post :change_settings, params: { skin: @skin.id , enemy: @enemy.id , sword: @sword.id , landscape: @landscape.id }
  			expect(assigns(:sword)).to eq @sword
  		end
  		it 'assing the choosen landscape to a variable' do
  			post :change_settings, params: { skin: @skin.id , enemy: @enemy.id , sword: @sword.id , landscape: @landscape.id }
  			expect(assigns(:landscape)).to eq @landscape
  		end
  		it "change the current user's skin with the choosen one" do
  			post :change_settings, params: { skin: @skin.id , enemy: @enemy.id , sword: @sword.id , landscape: @landscape.id }
  			user = User.find_by(id: @user.id)
  			expect(user.skin).to eq @skin
  		end
  		it "change the current user's enemy with the choosen one" do
  			post :change_settings, params: { skin: @skin.id , enemy: @enemy.id , sword: @sword.id , landscape: @landscape.id }
  			user = User.find_by(id: @user.id)
  			expect(user.enemy).to eq @enemy
  		end
  		it "change the current user's sword with the choosen one" do
  			post :change_settings, params: { skin: @skin.id , enemy: @enemy.id , sword: @sword.id , landscape: @landscape.id }
  			user = User.find_by(id: @user.id)
  			expect(user.sword).to eq @sword
  		end
  		it "change the current user's landscape with the choosen one" do
  			post :change_settings, params: { skin: @skin.id , enemy: @enemy.id , sword: @sword.id , landscape: @landscape.id }
  			user = User.find_by(id: @user.id)
  			expect(user.landscape).to eq @landscape
  		end
  		it 'redirect to the games settings page' do
  			post :change_settings, params: { skin: @skin.id , enemy: @enemy.id , sword: @sword.id , landscape: @landscape.id }
  			expect(response).to redirect_to '/settings'
  		end
  	end
	end

	#TODO controller test for #game!!!!

end
