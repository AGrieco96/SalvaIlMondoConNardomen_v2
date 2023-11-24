class GameMastersController < ApplicationController
	before_action :authenticate_user!
	before_action :master_user

	def index
		@users = User.paginate(page: params[:page])
		@banned_user = Ban.where(request: false).paginate(page: params[:page])
		@request_ban = Ban.where(request: true).paginate(page: params[:page])
	end

	def ban
		@user = User.find(params[:user])
		@days = params[:days].to_i.days.from_now
		@permanent_ban = params[:request]
		if @permanent_ban 
			Ban.create!(user: @user, day_ban: nil, request: true)
		elsif params[:days] != ''
			Ban.create!(user: @user, day_ban: @days, request: false)
		end

		redirect_to(masterpanel_path)
	end


	private
		def master_user
			redirect_to(root_path) unless current_user.gm?
		end

end
