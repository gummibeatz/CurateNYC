class PostJavaFormatter
  def initialize(results, base_clothing)
    @results = results
    @base_clothing = base_clothing   
  end

  def create_outfits
    format_result
    puts "@results after formatResult = #{@results}"
    assemble_outfits
  end

  def assemble_outfits
     
  end
  
  def format_result
    puts "@results in formatResult = #{@results}"
    @results.each_with_index do |result, idx|
      layer = result[0]
      result = result[1]
      result = result.split("\n")
      result.uniq!
      result.sort_by! {|i| i.split(" ").first.to_i }
      result.reverse!
      puts "layer = #{layer}"
      puts "result = #{result}"
      @results[idx] = [layer, result]
    end
     
  end


end
