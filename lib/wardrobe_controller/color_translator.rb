class ColorTranslator
	
	def initialize()
		@color_translator = Hash.new
		populate
	end

	def generalize(color)
		puts "in generalize, color = #{color}\n========="
		return @color_translator[color].first
	end

	def specify(color)
		return @color_translator[color]
	end

	private
	def populate()
		@color_translator["beige"] = ["light_brown"]
		@color_translator["berry"] = ["red"]
		@color_translator["black"] = ["black","charcoal"]
		@color_translator["blue"] = ["blue","teal"]
		@color_translator["brown"] = ["brown"]
		@color_translator["burgundy"] = ["dark_red"]
		@color_translator["charcoal"] = ["black"]
		@color_translator["dark_blue"] = ["dark_blue","navy"]
		@color_translator["dark_green"] = ["dark_green","olive"]
		@color_translator["dark_red"] =["burgundy","maroon"]
		@color_translator["gray"] = ["gray"]
		@color_translator["green"] = ["green"]
		@color_translator["lavender"] = ["light_purple"]
		@color_translator["light_purple"] = ["lavender"]
		@color_translator["light_blue"] = ["light_blue","turquoise"]
		@color_translator["light_gray"] = ["light_gray"]
		@color_translator["light_red"] = ["pink","salmon"]
		@color_translator["maroon"] = ["dark_red"]
		@color_translator["navy"] = ["dark_blue"]
		@color_translator["olive"] = ["dark_green"]
		@color_translator["pink"] = ["light_red"]
		@color_translator["purple"] = ["purple"]
		@color_translator["red"] = ["red"]
		@color_translator["salmon"] = ["light_red"]
		@color_translator["teal"] = ["blue"]
		@color_translator["turquoise"] = ["light_blue"]
		@color_translator["white"] = ["white"]
		@color_translator["yellow"] = ["yellow"]
	end

end