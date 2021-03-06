class GamePlaysController < ApplicationController
	before_action :signed_in_user

	def index
		@game_plays = current_user.game_plays.reverse
	end

	def edit
	end

	def new
		@game_play = GamePlay.new
		@board_games = current_user.board_games.sort_by { |b| b.name }
		@players = current_user.players.sort_by { |n| n.name }
	end

	def update
	end

	def show
		@game_play = GamePlay.find(params[:id])
	end

	def create
		@game_play = current_user.game_plays.build()
		@game_play.board_game = BoardGame.find_by_id(params[:board_game_id])

		player_ids = params[:game_play][:player_ids].select { |p| !p.empty? }

		player_ids.each do |p|
			player = Player.find_by_id(p)
			@game_play.players << player
		end
		
		if @game_play.save
			redirect_to game_plays_path
		else
			render 'new'
		end
	end

	def destroy
		GamePlay.destroy(params[:id])
		redirect_to game_plays_path
	end
end
