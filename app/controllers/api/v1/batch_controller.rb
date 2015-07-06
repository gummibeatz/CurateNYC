class Api::V1::BatchController < Api::ApiController
  include ActionController::MimeResponds
  respond_to :json

  def index
    @array = []
    if Clothing.count > 1
      if params[:batch_folder] != nil
        for i in (1..18)
          # check to see if it's of the correct batch folder
          @array.push(findClothesWithBatchFolder(i,params[:batch_folder]))
          # break
        end
        render json: @array
      else
        render json: Clothing.all
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