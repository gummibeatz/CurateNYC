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
		colors = @color_translator[color]
		puts "colors in colors translator = #{colors}"
		return @color_translator[color]
	end

	private
	def populate()
		@color_translator["beige"] = ["light_brown"]
		@color_translator["berry"] = ["red"]
		@color_translator["black"] = ["black","charcoal"]
		@color_translator["blue"] = ["blue","teal"]
		@color_translator["brown"] = ["brown","camo"]
		@color_translator["burgundy"] = ["dark_red"]
		@color_translator["charcoal"] = ["black"]
		@color_translator["camo"] = ["brown"]
		@color_translator["dark_blue"] = ["dark_blue","navy","indigo"]
		@color_translator["dark_purple"] = ["dark_purple"]
		@color_translator["dark_brown"] = ["dark_brown"]
		@color_translator["dark_gray"] = ["dark_gray"]
		@color_translator["dark_green"] = ["dark_green","olive"]
		@color_translator["dark_red"] =["dark_red","burgundy","maroon"]
		@color_translator["gray"] = ["gray"]
		@color_translator["green"] = ["green"]
		@color_translator["indigo"] = ["dark_blue"]
		@color_translator["khaki"] = ["light_brown"]
		@color_translator["lavender"] = ["light_purple"]
		@color_translator["light_purple"] = ["light_purple","lavender"]
		@color_translator["light_blue"] = ["light_blue","turquoise"]
		@color_translator["light_brown"] = ["light_brown","khaki","tan","taupe"]
		@color_translator["light_gray"] = ["light_gray"]
		@color_translator["light_red"] = ["light_red","pink","salmon"]
		@color_translator["maroon"] = ["dark_red"]
		@color_translator["navy"] = ["dark_blue"]
		@color_translator["olive"] = ["dark_green"]
		@color_translator["pink"] = ["light_red"]
		@color_translator["purple"] = ["purple"]
		@color_translator["red"] = ["red"]
		@color_translator["salmon"] = ["light_red"]
		@color_translator["tan"] = ["light_brown"]
		@color_translator["taupe"] = ["light_brown"]
		@color_translator["teal"] = ["blue"]
		@color_translator["turquoise"] = ["light_blue"]
		@color_translator["white"] = ["white"]
		@color_translator["yellow"] = ["yellow"]
		@color_translator["orange"] = ["orange"]
	end

end