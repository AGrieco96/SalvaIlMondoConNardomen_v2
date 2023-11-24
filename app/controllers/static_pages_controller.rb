class StaticPagesController < ApplicationController
  
  def home
  	if user_signed_in?
  		@scores = current_user.feed.paginate(page: params[:page])
  	end
  end

  def about
  end

  def contact
  end

  def other
  end

  def privacy
  end
  
end
