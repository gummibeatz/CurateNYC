class Api::V1::LikeController < Api::ApiController
  include ActionController::MimeResponds
  respond_to :json
  # def index
  #   respond_to do |format|
  #     @likes = Like.all
  #     format.json { render json:@likes}
  #   end
  # end

  # def index
  #   like = Like.find(id = current_user.id)
  #   render json:like
  # end

  def show
    render :status =>200,
               :json=>current_user
  end

  def index
    if params[:authentication_token] != nil
      if User.find_by_authentication_token(authentication_token = params[:authentication_token])
        @user = User.find_by_authentication_token(authentication_token = params[:authentication_token])
        @like = Like.find_by_user_id(user_id = @user.id)
        logger.info("Successful #{@user.name} connection to like json.")
        render :status =>200,
               :json=>@like
      else
        logger.info("Failed connection to like json, a user cannot be found by that authentication_token.")
        render :status =>200,
               :json=>{:message=>"Failed like connection, a user cannot be found by that authentication_token."}
      end
    else
      logger.info("Failed connection to like json, no authentication token posted.")
      render :status=>400,
            :json=>{:message=>"Did you add the user's authentication_token?"}
      return
    end
  end
  def update
    if params[:authentication_token] != nil
      if Like.find_by_authentication_token(authentication_token = params[:authentication_token])
        @like = Like.find_by_authentication_token(authentication_token = params[:authentication_token])
        @like.likes = params[:likes]
        @like.save!
      else
        logger.info("Failed connection to like/edit json, a like cannot be found by that authentication_token.")
        render :status =>200,
               :json=>{:message=>"Failed connection to like/edit json, a like cannot be found by that authentication_token."}
      end
    else
      logger.info("Failed connection to like/edit json, no authentication token posted.")
      render :status=>400,
            :json=>{:message=>"Did you add the like's authentication_token?"}
      return
    end
  end
end