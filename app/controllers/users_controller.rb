require 'koala'

class UsersController < ApplicationController
	before_action :authenticate_user!

	def show
		@user = User.find(params[:id])
		@scores = @user.scores.paginate(page: params[:page])
	end

	def index
	end

	def search
		@users = nil
  	if params[:nick]
  		if params[:nick] == ''
  			@users = nil
  		else
    		@users = User.search(params[:nick]).order(:nickname.downcase)
    	end
    else
    	redirect_to root_path
    end
	end

	def find_friends
		@user = current_user
		if @user.provider == "facebook"
			@oauth = Koala::Facebook::OAuth.new('445360272621130', ENV['FB_SECRET_KEY'])
			@graph = Koala::Facebook::API.new(@user.token)
			@friends_list = @graph.get_connections('me' , "friends")
			@friends = Array.new
			@friends_list.each do |friend|
				@friends << User.find_by(uid: friend['id'])
			end
		end
	end

	def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

end
