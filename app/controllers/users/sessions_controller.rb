# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
  	user_info = params[:user]
  	user = User.find_by(email: user_info[:email])
  	if User.all.include?(user)
  		ban = Ban.find_by(user: user)
  		if Ban.all.include?(ban)
  			if ban.day_ban > 500.years.from_now
  				redirect_to '/login', :notice => "You are banned permanently. Good Bye!"
  				return
  			elsif ban.day_ban > DateTime.now.in_time_zone
  				redirect_to '/login', :notice => "You are banned until #{ban.day_ban}"
  				return
  			else
  				ban.destroy
  			end
  		end
  	end
    super
    current_user.update({ token: '', provider: '', uid: ''})
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
