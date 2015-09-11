class Api::V1::BatchController < Api::ApiController
  include ActionController::MimeResponds
  respond_to :json

    @batch_order = File.read(File.join(Rails.root, 'public', 'batch_order.txt'))

  def index
    seed = Random.new(1)
    clothing_count = Top.count + Bottom.count
    @array = []
    if clothing_count > 0
      if params[:batch_folder] != nil
        for i in (1..18)
          # check to see if it's of the correct batch folder
          @array.push(findClothesWithBatchFolder(i,params[:batch_folder]))
        end
        render json: @array
      else
        all_priority_clothing = Top.priorities + Bottom.priorities
        all_not_priority_clothing = Top.where(priority: false) + Bottom.where(priority: false)
        
        puts @batch_order

        all_priority_clothing.shuffle!(random: seed)
        all_not_priority_clothing.shuffle!(random: seed)
        
        all_clothing = all_priority_clothing + all_not_priority_clothing
        
        render json: all_clothing.each_slice(20).to_a #splits it up into batches  
      end
    else
      logger.info("Oh damn the batches aren't here! Call Christina!")
      render :status =>200,
             :json=>{:message=>"Shit there aren't any batches in here"}
    end
  end

  # returns an array of tops with batch_folder given a param
  # to search in sql db
  def findClothesWithBatchFolder(num,batch_folder)
    clothes =[]
    Clothing.where(number: num).each do |clothing|
      clothing.batch_information.each do |batch_type|
        if batch_type.include?(batch_folder)
          clothes.push(clothing)
          break
        end
      end
    end
    return clothes
  end

end
