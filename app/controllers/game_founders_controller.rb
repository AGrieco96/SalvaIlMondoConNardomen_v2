class GameFoundersController < ApplicationController
	before_action :authenticate_user!
	before_action :founder_user

	def index
		@users = User.paginate(page: params[:page])
		@banned_user = Ban.where(request: false).paginate(page: params[:page])
		@request_ban = Ban.where(request: true).paginate(page: params[:page])
	end

	def ban
		@user = User.find(params[:user])
		@days = params[:days].to_i.days.from_now
		@permanent_ban = params[:permanent]
		if @permanent_ban 
			Ban.create(user: @user, day_ban: 1_000_000.years.from_now, request: false)
		elsif params[:days] != ''
			Ban.create(user: @user, day_ban: @days, request: false)
		end

		redirect_to(founderpanel_path)
	end

	def remove
		@user = Ban.find_by(user: params[:user])
		@user.destroy

		redirect_to(founderpanel_path)
	end

	def promote
		@user = User.find(params[:user])
		@user.update_attribute(:gm, true)

		redirect_to(founderpanel_path)
	end

	def demote
		@user = User.find(params[:user])
		@user.update_attribute(:gm, false)

		redirect_to(founderpanel_path)
	end

	def approve
		@user = Ban.find_by(user: params[:user])
		@approve = params[:approve]
		if @approve == "Ban"
			@user.update_attribute(:request, false)
			@user.update_attribute(:day_ban, 1_000_000.years.from_now)
		elsif @approve == "Cancel"
			@user.destroy
		end
		
		redirect_to(founderpanel_path)
	end

	private
		def founder_user
			redirect_to(root_path) unless current_user.gf?
		end
end
