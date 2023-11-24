require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
	# static_pages#home
	describe 'get #home' do		
		# no logged user
		context 'When user is not logged in' do
			it 'render the homepage' do
				get :home
				expect(response).to render_template :home
			end
		end
		# logged user
		context 'When user is logged in' do
			#login
			before :each do
				@request.env['devise.mapping'] = Devise.mappings[:user]
				@user = FactoryBot.create(:complete_user)
				sign_in @user
				@scores = FactoryBot.create_list(:score, 10, user:@user)
			end
			# @scores array
			it 'populates an array of scores' do
				get :home
				@scores.each do |score| 
  				expect(assigns(:scores)).to include (score)
  			end
			end
			#render page
			it 'render the logged homepage' do
				get :home
				expect(response).to render_template :home
			end
		end
	end

	# static_pages#about
	describe 'get #about' do
		# no logged user
		context 'When user is not logged in' do
			it 'render the about page' do
				get :about
				expect(response).to render_template :about
			end 
		end
		# logged user
		context "When user is logged in" do
			it 'render the about page' do
				get :about
				expect(response).to render_template :about
			end 
		end
	end

	# static_pages#contact
	describe 'get #contact' do
		# no logged user
		context 'When user is not logged in' do
			it 'render the contact page' do
				get :contact
				expect(response).to render_template :contact
			end 
		end
		# logged user
		context "When user is logged in" do
			it 'render the contact page' do
				get :contact
				expect(response).to render_template :contact
			end 
		end
	end	

	# static_pages#other
	describe 'get #other' do
		# no logged user
		context 'When user is not logged in' do
			it 'render the other page' do
				get :other
				expect(response).to render_template :other
			end 
		end
		# logged user
		context "When user is logged in" do
			it 'render the other page' do
				get :other
				expect(response).to render_template :other
			end 
		end
	end	

	# static_pages#privacy
	describe 'get #privacy' do
		# no logged user
		context 'When user is not logged in' do
			it 'render the privacy page' do
				get :privacy
				expect(response).to render_template :privacy
			end 
		end
		# logged user
		context "When user is logged in" do
			it 'render the privacy page' do
				get :privacy
				expect(response).to render_template :privacy
			end 
		end
	end	

end
