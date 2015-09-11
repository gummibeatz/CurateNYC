class Api::V1::BatchController < Api::ApiController
  include ActionController::MimeResponds
  respond_to :json

  
  def index
    @array = []
    if Top.count + Bottom.count > 0
      if params[:batch_folder] != nil
        for i in (1..18)
          # check to see if it's of the correct batch folder
          @array.push(findClothesWithBatchFolder(i,params[:batch_folder]))
        end
        render json: @array
      else
        tops = Top.order(:row_number)
        bottoms = Bottom.order(:row_number)
        
        render json: merge_clothing(tops, bottoms).each_slice(20).to_a

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

  private

  def merge_clothing(tops, bottoms)
    count = 0
    total_count = tops.count + bottoms.count
    clothes = []
    top_ct = 0
    bottom_ct = 0

    while count < total_count
      if top_ct == tops.count then return clothes.concat(bottoms[bottom_ct, bottoms.count - 1])
      elsif bottom_ct == bottoms.count then return clothes.concat(tops[top_ct, tops.count - 1])
      else
        if tops[top_ct].row_number < bottoms[bottom_ct].row_number
          clothes.push tops[top_ct]
          top_ct+=1
        else
          clothes.push bottoms[bottom_ct]
          bottom_ct+=1
        end
      end
    end
  end

end
