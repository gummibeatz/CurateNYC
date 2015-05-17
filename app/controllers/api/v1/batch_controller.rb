class Api::V1::BatchController < Api::ApiController
  include ActionController::MimeResponds
  respond_to :json
  def index
    @array = []
    i = 1
    if Tops.count > 1
      if params[:batch_folder] != nil
        while i < 19
          @array << Tops.where(number: i)
          i+=1
        end
        render json: @array
      else
        render json: Tops.all
      end
    else
      logger.info("Oh damn the batches aren't here! Call Christina!")
      render :status =>200,
             :json=>{:message=>"Shit there aren't any batches in here"}
    end
  end
end