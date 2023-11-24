require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do

	describe 'POST #create' do
		# no logged in
		context 'When user is not logged in' do
			it 'redirect to the login page' do
				post :create
				expect(response).to redirect_to '/login'
			end
		end
		# user logged in
		context 'When user is logged in' do
			before :each do
    		@request.env['devise.mapping'] = Devise.mappings[:user]
				@user = FactoryBot.create(:complete_user)
				sign_in @user
				@other_user = FactoryBot.create(:complete_user)
  		end
  		it 'assigns @other_user to user' do
  			post :create, params: {followed_id: @other_user.id}
  			expect(assigns(:user)).to eq @other_user
  		end
  		it 'Add @other_user to current_user.following' do
  			post :create, params: {followed_id: @other_user.id}
  			expect(@user.following).to include @other_user
  		end
  		it 'redirect to @other_user profile' do
  			post :create, params: {followed_id: @other_user.id}
  			expect(response).to redirect_to @other_user
  		end
		end
	end

	# describe 'DELETE #destroy' do
	# 	# no logged in
	# 	context 'When user is not logged in' do
	# 		it 'redirect to the login page' do
	# 			delete :destroy
	# 			expect(response).to redirect_to '/login'
	# 		end
	# 	end
	# end
	# # user logged in
	# 	context 'When user is logged in' do
	# 		before :each do
  #    		@request.env['devise.mapping'] = Devise.mappings[:user]
	# 			@user = FactoryBot.create(:complete_user)
	# 			sign_in @user
	# 			@other_user = FactoryBot.create(:complete_user)
	# 			@user.follow(@other_user)
  #  		end

  #  		it 'remove @other_user to current_user.following' do
  #  			delete :destroy, params: {followed_id: @other_user.id}
  #  			expect(@user.following).to include @other_user
  #  		end
  #  	end
end
