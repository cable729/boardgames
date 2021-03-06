class GamePlay < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :board_games
	has_and_belongs_to_many :players

	def board_game
		if self.board_games.any?
			self.board_games.first
		else
			nil
		end
	end

	def board_game=(board_game)
		if self.board_games.any?
			self.board_games.delete_all
		end
		
		self.board_games.push board_game
	end

	def date_string
		self.created_at.localtime.strftime("%-m/%d/%y")
	end

	def players_string
		if self.players.any?
			self.players.sort_by { |p| p.name }.collect { |p| p.name }.join(", ")
		else
			"Solo play"
		end
	end

	def player_count_string
		"Players: #{self.players.count + 1}"
	end
end
