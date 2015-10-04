class PreJavaFormatter

	# takes in the Temperature in Farenheith
	# and tops and bottoms of the user
	def initialize(temp,base_clothing,tops, bottoms, color_translator)
		@temp = temp
		@tops = tops
		@bottoms = bottoms
		@base_clothing = base_clothing
		@color_translator = color_translator
		@bad_colors = ["printed","check","gingham","striped","dots","light wash", "chambray", "acid wash"]
	end

	def formatJavaParams()
		javaParams = formatBaseClothing
    puts "javaParams = #{javaParams}"
		javaParams.map! do |param|
			layer = param.split(' ').first.dup
      puts "layer = #{layer}"
			param.prepend(" ").prepend(chooseTempCondition)
      puts "1param = #{param}"
			param << formatBottoms(layer)
      puts "2param = #{param}"
			temp_param,layer1_cat= formatLayer1(layer)
			param << temp_param
      puts "3param = #{param}"
			param << formatLayer2(layer, layer1_cat)
			param << formatLayer3(layer)
		end
    puts "javaParams = #{javaParams}"
		return javaParams
	end

	private
	def chooseTempCondition()
		case @temp.to_i
		when -100..49
			return "warm"
		when 50..59
			return "warm"
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
      ct = 0
      colors =""
			for bottom in @bottoms
				colors << generalizeColors(bottom,true)
			#	colors << bottom.color_1.downcase.tr(' ', '_')
				colors << " "
        ct += 1
			end
      colors.prepend(" ").prepend(ct.to_s)
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
				if top.first_layer and
					(!top.main_category.eql? @base_category)
					colors << generalizeColors(top,true)
					colors << " "
					layer1_cat = top.main_category
					ct += 1
				end
			end
			return colors.prepend(" ").prepend(ct.to_s), layer1_cat
		end
	end

	def formatLayer2(layer, layer1_cat)
		puts "base_category = #{@base_category}"
		if layer.eql? "l2"
			return "0 "
		else
			colors = " "
			ct = 0
			for top in @tops
				# will only add if it has the layer property
				# and it is not the same main category as the base clothing
				if top.second_layer and
					(!top.main_category.eql? @base_category) and
					(!top.main_category.eql? layer1_cat)
					
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
			colors = " "
			ct = 0
			for top in @tops
				# will only add if it has the layer property
				# and it is not the same main category as the base clothing
				if top[:properties][:first_layer].eql? "y" and
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
    
		clothing = Top.where(file_name: @base_clothing).first || Bottom.where(file_name: @base_clothing).first
    puts clothing.main_category
		baseParams = chooseLayers(clothing)
		color = generalizeColors(clothing)
    baseParams.map! {|p| p << " " << color << " "}
    return baseParams
	end

	def chooseLayers(clothing)
		if clothing.main_category.eql? "pants" || "shorts"
			return ["bottoms"]
		else
			layers = []
			if clothing.first_layer
				layers.append("l1")
			end
			if clothing.second_layer
				layers.append("l2")
			end
			# add in other layers when needed
			# if clothing.first.properties["third_layer"].eql? "x"
			# 	layers.append("l3")
			# end
			# if clothing.first.properties["fourth_layer"].eql? "x"
			# 	layers.append("l4")
			# end
      puts layers
			return layers
		end
	end

	# generalizes colors down to colors in the scoringCSVs
	def generalizeColors(clothing, isHash = false)
		color = checkColors(clothing, isHash).downcase.tr(' ', '_')
		puts "in generalizeColors, color =#{color}"
		return @color_translator.generalize(color)
	end

	# double checks that color_1 is actually a color
	# and returns the correct 
	def checkColors(clothing, isHash)
		puts "in checkColors, color = #{clothing.color_1} \n \
		       file_name = #{clothing.file_name}"
		if clothing.color_1
			if @bad_colors.include? clothing.color_1.downcase
				return clothing.color_2
			end
			return clothing.color_1
		else
			if @bad_colors.include? clothing.color_1
				return clothing.color_2
			end
			return clothing.color_1
		end
	end

end
