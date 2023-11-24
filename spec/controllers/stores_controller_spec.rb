require 'rails_helper'

RSpec.describe StoresController, type: :controller do

	describe 'GET #index' do
		# no logged user
		context 'When user is not logged in' do
			it 'redirect to login page' do
				get :index
				expect(response).to redirect_to '/login'
			end
		end
		# logged user
		context 'When user is logged in' do
			before :each do
    		@request.env['devise.mapping'] = Devise.mappings[:user]
				@user = FactoryBot.create(:complete_user)
				sign_in @user
  		end
			it 'assign to @user the current user' do 
				get :index
				expect(assigns(:user)).to eq @user
			end
			it 'populates an array of skins' do 
				get :index
				expect(assigns(:skins)).to eq @user.skins
			end
			it 'populates an array of enemies' do 
				get :index
				expect(assigns(:enemies)).to eq @user.enemies
			end
			it 'populates an array of swords' do 
				get :index
				expect(assigns(:swords)).to eq @user.swords
			end
			it 'populates an array of landscapes' do 
				get :index
				expect(assigns(:landscapes)).to eq @user.landscapes
			end
			it 'render the store page' do
				get :index
				expect(response).to render_template :index
			end
		end
	end

	describe 'POST #buy' do
		# no logged user
		context 'When user is not logged in' do
			it 'redirect to login page' do
				post :buy
				expect(response).to redirect_to '/login'
			end
		end
		# logged user
		context 'When user is logged in' do
			before :each do
    		@request.env['devise.mapping'] = Devise.mappings[:user]
				@user = FactoryBot.create(:complete_user)
				@item = FactoryBot.create(:item, level: Random.rand(@user.level), price: Random.rand(@user.money))
				@bad_item = FactoryBot.create(:item, level: @user.level+Random.rand(5), price: @user.money+Random.rand(100))
				sign_in @user
  		end
  		it 'assign item to a variable' do
  			post :buy, params: { item: @item.name }
  			expect(assigns(:item)).to eq @item
  		end
  		it "add the item in user's items if valid" do
  			post :buy, params: { item: @item.name }
  			expect(@user.items).to include @item
  		end
  		it "not add item in user's item if not valid" do
  			post :buy, params: { item: @bad_item.name }
  			expect(@user.items).to_not include @bad_item
  		end
		end
	end

end
