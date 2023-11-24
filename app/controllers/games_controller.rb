class GamesController < ApplicationController
	before_action :authenticate_user!

	def settings
		@user =current_user
	end

	def change_settings
		@skin = current_user.items.find_by(id: params[:skin])
		@enemy = current_user.items.find_by(id: params[:enemy])
		@sword = current_user.items.find_by(id: params[:sword])
		@landscape = current_user.items.find_by(id: params[:landscape])

		if @skin != current_user.skin
			current_user.change_skin(@skin)
		end

		if @enemy != current_user.enemy
			current_user.change_enemy(@enemy)
		end

		if @sword != current_user.sword
			current_user.change_sword(@sword)
		end

		if @landscape != current_user.landscape
			current_user.change_landscape(@landscape)
		end
		redirect_to '/settings', :notice => "Changes saved successfull"
	end

	def game

	end

	def get_score
		@user 	= current_user
		@score 	= params[:score].to_i
		@money 	= @score/10
		@exp 		= @score/2
		@user.scores.create(score: @score)
		@user.game_datum.update({
			money: 	@user.money+@money,
			exp: 		@user.exp+@exp
			})
		if @user.exp > @user.level*1000
			@user.game_datum.update({ level: @user.level + 1})
		end
		redirect_to '/game'
	end

end
