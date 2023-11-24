class StoresController < ApplicationController
	before_action :authenticate_user!

	def index
		@shop = Shop.new
		@user = current_user
		@skins = Item.skins
		@enemies = Item.enemies
		@swords = Item.swords
		@landscapes = Item.landscapes
	end

	def buy
		@item = Item.find_by(name: params[:item])
  	if current_user.level >= @item.level && current_user.money >= @item.price
  		current_user.items << @item
  		money = current_user.money - @item.price
  		current_user.game_datum.update_attribute(:money, money)
  		redirect_to '/store', :notice => "#{@item.name} purchased"
  	else
  		redirect_to '/store', :notice => "#{@item.name} not purchased.\nCheck your level or your money"
  	end
	end


end
