class JavaRunner

	def initialize(java_params, base_clothing, tops, bottoms, color_translator)
		@java_params = java_params
    @base_clothing = base_clothing
		@base_file_name = base_clothing[:file_name]
		@tops = tops
		@bottoms = bottoms
    @color_translator = color_translator
	end

	def run
		outfits = []

		@java_params.each do |param|
      v = `java -cp ./java_algos ScoringAlgo #{param}`
      orig_layer = param.split(' ')[1]

      # puts layer
      puts param

      # if no results and if the base clothes was run as a first layer
      # then try again with lowest degree of matches(2)
      if v.empty? and ((orig_layer.eql? "l1") or (orig_layer.eql? "bottoms"))
        puts "rerunning due to no results on first run as l1"
        v = `java -cp ./java_algos ScoringAlgo #{reformatForMatch2(param)}`
      end
      
      if !v.empty?
        for out in v.split("\n")
          results = assembleOutfits(out, orig_layer)
          if results then outfits << results end
        end
      end
    end

    if outfits.empty?
      return "NA"
    end
    return outfits
	end

	private
	def reformatForMatch2(param)
		# hot weather will only ever do a match2
		puts "in reformat"
		return param.split(' ')[1..-1].join(' ').prepend("hot ")
  end

	def assembleOutfits(out, orig_layer)
    puts"in assemble outfits \n========\n\n"
		score = out.split(' ')[0]
	 	colors = out.split(' ')[1..-1]
    matches = Hash.new
    matches[:score] = score
    puts "matches[:score] = #{score}"
	 	# Should be n nested loops, for n clothes 
    # exhaustive search
    # first loop through colors array

    bottom_colors = Array(@color_translator.specify(colors[0]))
    l1_colors = Array(@color_translator.specify(colors[1]))
    # if l1_colors.size > 0
    #   l1_colors.map! {|x| puts "l1_color is #{x}"}
    # end
    puts "l1_colors = #{l1_colors}"
    l2_colors = Array(@color_translator.specify(colors[2]))
    # if l2_colors.size > 0
    #   l2_colors.map! {|x| puts "l2_color is #{x}"}
    # end
    puts "l2_colors = #{l2_colors}"
    bottoms = getClothesWithAttributes(bottom_colors,"bottoms")
	  l1s = getClothesWithAttributes(l1_colors,"l1")
    l2s = getClothesWithAttributes(l2_colors,"l2")
    outfits = []
    print("bottoms are #{bottoms}\n")
    print("l1s are #{l1s}\n")
    print("l2s are #{l2s}\n")


    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

    case orig_layer
    when "bottoms"
      for l1 in l1s
        category = Clothing.where(file_name: l1).first[:properties]["main_category"].downcase
        if l2s.count>0 and !category.eql? "light layer"
          for l2 in l2s
            outfit = [@base_file_name, l1, l2]
            outfits << outfit
          end
        else
          outfit = [@base_file_name, l1, "NA"]
          outfits << outfit
        end
      end
    when "l1"
      puts "it's l1"
      category = @base_clothing[:properties]["main_category"].downcase
      for b in bottoms
        if l2s.count>0 and !category.eql? "light layer"
          for l2 in l2s
            outfit = [b,@base_file_name,l2]
            outfits << outfit
            puts "inside l1 innerest loop \noutfit=#{outfit}"
          end
        else
          outfit = [b, @base_file_name, "NA"]
          outfits << outfit
        end
      end
    when "l2"
      puts "it's l2"
      for b in bottoms
        for l1 in l1s
          category = Clothing.where(file_name: l1).first[:properties]["main_category"].downcase
          # don't want light layer under anything
          if !category.eql? "light layer"
            outfit = [b,l1,@base_file_name]
            outfits << outfit
          end
        end
      end
    end

    puts"outfits = #{outfits}"
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~``"
    if outfits.empty?
      return nil
    end
    matches[:outfits] = outfits
    return matches
  end 

  def getClothesWithAttributes(colors,layer)
    arr = []
    case layer
    when "bottoms"
      @bottoms.each do |bottom|
         if colors.include? getColor(bottom).downcase
          arr << bottom[:file_name]
         end
      end
    when "l1"
      @tops.each do |top|
        # print colors
        puts
         if colors.include? getColor(top).downcase
          arr << top[:file_name]
         end
      end
    when "l2"
      @tops.each do |top|
         if colors.include? getColor(top).downcase 
          arr << top[:file_name]
         end
      end
    end
    return arr
  end

  def getColor(clothes)
    # puts clothes[:properties][:color_1]
    if clothes[:properties][:color_1].downcase.eql? "printed" ||
      "check" || "gingham" || "striped" || "dots" || "light wash" ||
      "chambray" || "acid wash"
        return clothes[:properties][:color_2]
    end
    return clothes[:properties][:color_1]
  end

end