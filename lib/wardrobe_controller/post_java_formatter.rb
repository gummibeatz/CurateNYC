class PostJavaFormatter
  MAX_OUTFITS = 5
  LAYER_INDEX = {"bottoms" => 0,
                 "l1" => 1,
                 "l2" => 2}

  def initialize(results, base_clothing)
    @results = results
    @base_clothing = base_clothing
    @formatted_results = Array.new()
    @outfits = Array.new()
  end

  def create_outfits
    format_result
    puts "formatted_results = #{@formatted_results}"
    assemble_outfits
    puts "outfits = #{@outfits}"
  end

  def assemble_outfits
    puts "#{"=" * 5} in assemble outfits #{"=" * 5}"  
    #loop through the different layer results
    @formatted_results.each do |result|
      orig_layer = result[0]
      outfit = Array.new
      #loop through each individual result with a cap on outfits
      result[1][0..MAX_OUTFITS-1].each do |match|
        match = match.split(" ")
        #loop through the results to put filenames
        match[1..-1].each_with_index do |layer, i|
          if i != LAYER_INDEX[orig_layer]
            if i = 0 and Bottom.where(color_1: layer.gsub(" ", "_")).exists?
              outfit[i] = Bottom.where(color_1: layer.gsub(" ","_")).first.file_name  
            else
              if Top.where(color_1: layer.gsub(" ", "_")).exists?
                outfit[i] = Top.where(color_1: layer.gsub(" ","_")).first.file_name
              end
            end
          end
        end
        puts "match = #{match}"
      end
      outfit[LAYER_INDEX[orig_layer]] = @base_clothing.file_name
      @outfits << outfit  
      

    end
    puts "#{"=" * 5} out of assemble outfits #{"=" * 5}"
    @outfits
    
  end
  
  def format_result
    puts "@results in formatResult = #{@results}"
    @results.each do |result|
      orig_layer = result[0]
      result = result[1]
      result = result.split("\n")
      result.uniq!
      result.sort_by! {|i| i.split(" ").first.to_i }
      result.reverse!
      @formatted_results.push([orig_layer,result])
    end
  end

end
