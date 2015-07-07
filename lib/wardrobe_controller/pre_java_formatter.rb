class PreJavaFormatter

	# takes in the Temperature in Farenheith
	# and tops and bottoms array of the Wardrobe model
	def initialize(temp,base_clothing,tops, bottoms, color_translator)
		@temp = temp
		@tops = tops
		@bottoms = bottoms
		@base_clothing = base_clothing
		@base_category = Clothing.where(file_name: @base_clothing).first[:properties]["main_category"]
		@color_translator = color_translator
	end

	def formatJavaParams()
		javaParams = formatBaseClothing
		javaParams.map! do |param|
			layer = param.split(' ').first.dup
			param.prepend(" ").prepend(chooseTempCondition)
			param << formatBottoms(layer)
			temp_param,layer1_cat= formatLayer1(layer)
			param << temp_param
			param << formatLayer2(layer, layer1_cat)
			param << formatLayer3(layer)
		end
		return javaParams
	end

	private
	def chooseTempCondition()
		case @temp.to_i
		when -100..49
			return "cold"
		when 50..59
			return "brisk"
		when 60..69
			return "warm"
		when 70..200
			return "hot"
		else
			return "temp not in range. you might be dead..."
		end
	end

	def formatBottoms(layer)
		if layer.eql? "bottoms"
			return "0 "
		else
			colors = @bottoms.count.to_s + " "
			for bottom in @bottoms
				colors << generalizeColors(bottom,true)
				# colors << bottom[:properties][:color_1].downcase.tr(' ', '_')
				colors << " "
			end
			return colors
		end
	end

	def formatLayer1(layer)
		if layer.eql? "l1"
			return "0 "
		else
			layer1_cat = ""
			colors = ""
			ct = 0
			for top in @tops
				# will only add if it has the layer property
				# and it is not the same main category as the base clothing
				if top[:properties][:first_layer].eql? "x" and
					(!top[:properties][:main_category].eql? @base_category)
					colors << generalizeColors(top,true)
					colors << " "
					layer1_cat = top[:properties][:main_category]
					ct += 1
				end
			end
			return colors.prepend(" ").prepend(ct.to_s), layer1_cat
		end
	end

	def formatLayer2(layer, layer1_cat)
		puts @base_category
		if layer.eql? "l2"
			return "0 "
		else
			colors = ""
			ct = 0
			for top in @tops
				# will only add if it has the layer property
				# and it is not the same main category as the base clothing
				if top[:properties][:first_layer].eql? "x" and
					(!top[:properties][:main_category].eql? @base_category) and
					(!top[:properties][:main_category].eql? layer1_cat)
					
					colors << generalizeColors(top,true)
					colors << " "
					ct += 1
				end
			end
			return colors.prepend(" ").prepend(ct.to_s)
		end
	end

	def formatLayer3(layer)
		return "0"
		# need to add in suit jackets before fixing this
		if layer.eql? "l3"
			return "0 "
		else
			colors = ""
			ct = 0
			for top in @tops
				# will only add if it has the layer property
				# and it is not the same main category as the base clothing
				if top[:properties][:first_layer].eql? "x" and
					(!top[:properties][:main_category].eql? @base_category)
					
					colors << generalizeColors(top,true)
					colors << " "
					ct += 1
				end
			end
			return colors.prepend(" ").prepend(ct.to_s)
		end
	end

	def formatBaseClothing()
		str = ""
		clothing=Clothing.where(file_name: @base_clothing).first
		baseParams = chooseLayers(clothing)
		color = generalizeColors(clothing)
		baseParams.map! {|p| p << " " << color << " "}
		return baseParams
	end

	def chooseLayers(clothing)
		if clothing.properties["main_category"].eql? "Casual" ||
			"Chinos" || "Shorts" || "Suit Pants"
			return ["bottoms"]
		else
			layers = []
			if clothing.properties["first_layer"].eql? "x"
				layers.append("l1")
			end
			if clothing.properties["second_layer"].eql? "x"
				layers.append("l2")
			end
			# add in other layers when needed
			# if clothing.first.properties["third_layer"].eql? "x"
			# 	layers.append("l3")
			# end
			# if clothing.first.properties["fourth_layer"].eql? "x"
			# 	layers.append("l4")
			# end
			return layers
		end
	end

	# generalizes colors down to colors in the scoringCSVs
	def generalizeColors(clothing, isHash = false)
		color = checkColors(clothing, isHash).downcase.tr(' ', '_')
		return @color_translator.generalize(color)
	end

	# double checks that color_1 is actually a color
	# and returns the correct 
	def checkColors(clothing, isHash)
		puts ("in checkColors, color = #{clothing[:properties][:color_1]"}
		if isHash
			if clothing[:properties][:color_1].downcase.eql? "printed" ||
				"check" || "gingham" || "striped" || "dots" || "light wash" ||
				"chambray" || "acid wash"
				return clothing[:properties][:color_2]
			end
			return clothing[:properties][:color_1]
		else
			if clothing[:properties]["color_1"].downcase.eql? "printed" ||
				"check" || "gingham" || "striped" || "dots" || "light wash" ||
				"chambray" || "acid wash"
				return clothing[:properties]["color_2"]
			end
			return clothing[:properties]["color_1"]
		end
	end

end