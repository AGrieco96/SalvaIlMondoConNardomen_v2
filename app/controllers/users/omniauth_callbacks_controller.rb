class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def facebook
    @user = User.create_from_facebook_omniauth(omniauth_params)
    if @user.persisted?
    	if User.all.include?(@user)
	  		ban = Ban.find_by(user: @user)
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
    	sign_in @user, event: :authentication 
    	if @user.created_at > 3.minutes.ago
    		redirect_to edit_user_registration_path(@user), :notice => 		"Sign up successfully.\nYour Nardomen account is linked with Facebook.\n
    																																	Change your nickname and your password (current: NardomenFriendlyPassword )\n
    																																	This password should be know by other user so it strongly recommended to change it!!"
    	else
    		redirect_to root_path, :notice => 		"Log in successfully.\nYour Nardomen account is linked with Facebook."
    	end
    end
  end

  def twitter
    @user = User.create_from_twitter_omniauth(omniauth_params)
    if @user.persisted?
    	if User.all.include?(@user)
	  		ban = Ban.find_by(user: @user)
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
    	sign_in @user, event: :authentication 
    	if @user.created_at > 3.minutes.ago
    		redirect_to edit_user_registration_path(@user), :notice => 		"Sign up successfully.\nYour Nardomen account is linked with Twitter.\n
    																																	Change your nickname and your password (current: NardomenFriendlyPassword ).
    																																	This password should be know by other user so it strongly recommended to change it!!"
    	else
    		redirect_to root_path, :notice => 		"Log in successfully.\nYour Nardomen account is linked with Twitter."
    	end
    end
  end
  
  private
  def omniauth_params
    request.env["omniauth.auth"]
  end

end