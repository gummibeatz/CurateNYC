class JavaRunner

	def initialize(java_params, base_clothing, tops, bottoms, color_translator)
		@java_params = java_params
		@base_clothing = base_clothing
		@tops = tops
		@bottoms = bottoms
    @color_translator = color_translator
	end

	def run
		outfits = []
		output = "" 
		@java_params.each do |param|
      v = `java -cp ./java_algos ScoringAlgo #{param}`
      layer = param.split(' ')[1]

      # puts layer
      puts param

      # if no results and if the base clothes was run as a first layer
      # then try again with lowest degree of matches(2)
      if v.empty? and ((layer.eql? "l1") or (layer.eql? "bottoms"))
        puts "rerunning due to no results on first run as l1"
        v = `java -cp ./java_algos ScoringAlgo #{reformatForMatch2(param)}`
      end
      output << v 
    end

    if output.empty?
      return "NA"
    end

    for out in output.split("\n")
    	outfits<<assembleOutfits(out)
      # outfits.flatten!(1)
    end

    return outfits
	end

	private
	def reformatForMatch2(param)
		# hot weather will only ever do a match2
		puts "in reformat"
		return param.split(' ')[1..-1].join(' ').prepend("hot ")
  end

	def assembleOutfits(out)
    puts"in assemble outfits \n========\n\n"
		score = out.split(' ')[0]
	 	colors = out.split(' ')[1..-1]
    matches = Hash.new
    matches[:score] = score
	 	# Should be n nested loops, for n clothes 
    # exhaustive search
    # first loop through colors array
    bottom_colors = Array(@color_translator.specify(colors[0]))
    l1_colors = Array(@color_translator.specify(colors[1]))
    l2_colors = Array(@color_translator.specify(colors[2]))
    bottoms = getClothesWithAttributes(bottom_colors,"bottoms")
	  l1s = getClothesWithAttributes(l1_colors,"l1")
    l2s = getClothesWithAttributes(l2_colors,"l2")

    outfits = []
    for b in bottoms
      for l1 in l1s
        if l2s.count>0
          for l2 in l2s
            outfit = [b,l1,l2]
            outfits << outfit
          end
        else
          outfit = [b,l1]
          outfits << outfit
        end
      end
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
    if clothes[:properties][:color_1].eql? "printed" ||
      "check" || "gingham" || "striped" || "dots" || "light wash" ||
      "chambray" || "acid wash"
        return clothes[:properties][:color_2]
    end
    return clothes[:properties][:color_1]
  end

end