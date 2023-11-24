class NotificationsController < ApplicationController
	before_action :authenticate_user!

	def show
		@notification = Notification.find_by(id: params[:id])
		@actor = @notification.actor
		@notification.destroy
		redirect_to @actor
	end

end
