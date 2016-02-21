class Api::V1::OutfitController < Api::ApiController
  include ActionController::MimeResponds
  respond_to :json

  # def index
  #   outfit = Outfit.find(id = current_user.id)
  #   render json:outfit
  # end

  def index
    if params[:authentication_token] != nil
      if User.find_by_authentication_token(authentication_token = params[:authentication_token])
        @user = User.find_by_authentication_token(authentication_token = params[:authentication_token])
        @outfit = Outfit.find_by_user_id(user_id = @user.id)
        logger.info("Successful #{@user.name} connection to outfit json.")
        render :status =>200,
               :json=>@outfit
      else
        logger.info("Failed connection to outfit json, a user cannot be found by that authentication_token.")
        render :status =>200,
               :json=>{:message=>"Failed outfit connection, a user cannot be found by that authentication_token."}
      end
    else
      logger.info("Failed connection to outfit json, no authentication token posted.")
      render :status=>400,
            :json=>{:message=>"Did you add the user's authentication_token?"}
      return
    end
  end

  def update
    if params[:authentication_token] != nil
      if Outfit.find_by_authentication_token(authentication_token = params[:authentication_token])
        @outfit = Outfit.find_by_authentication_token(authentication_token = params[:authentication_token])
        @outfit.outfit = params[:outfits]
        @outfit.save!
      else
        logger.info("Failed connection to outfit/edit json, a outfit cannot be found by that authentication_token.")
        render :status =>200,
               :json=>{:message=>"Failed connection to outfit/edit json, a outfit cannot be found by that authentication_token."}
      end
    else
      logger.info("Failed connection to outfit/edit json, no authentication token posted.")
      render :status=>400,
            :json=>{:message=>"Did you add the outfit's authentication_token?"}
      return
    end
  end
end
