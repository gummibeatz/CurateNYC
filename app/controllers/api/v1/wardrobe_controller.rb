class Api::V1::WardrobeController < Api::ApiController
  include ActionController::MimeResponds
  respond_to :json
  def index
    if params[:authentication_token] != nil
      if User.find_by_authentication_token(authentication_token = params[:authentication_token])
        @user = User.find_by_authentication_token(authentication_token = params[:authentication_token])
        @wardrobe = Wardrobe.find_by_user_id(user_id = @user.id)
        logger.info("Successful #{@user.name} connection to wardrobe json.")
        render :status =>200,
               :json=>@wardrobe
      else
        logger.info("Failed connection to wardrobe json, a user cannot be found by that authentication_token.")
        render :status =>400,
               :json=>{:message=>"Failed wardrobe connection, a user cannot be found by that authentication_token."}
      end
    else
      logger.info("Failed connection to wardrobe json, no authentication token posted.")
      render :status=>400,
            :json=>{:message=>"Did you add the user's authentication_token?"}
      return
    end
  end

  def update
    if params[:authentication_token] != nil
      if Wardrobe.find_by_authentication_token(authentication_token = params[:authentication_token])
        @wardrobe = Wardrobe.find_by_authentication_token(authentication_token = params[:authentication_token])
        @wardrobe.wardrobe = params[:wardrobe]
        @wardrobe.save!
      else
        logger.info("Failed connection to wardrobe/edit json, a wardrobe cannot be found by that authentication_token.")
        render :status =>400,
               :json=>{:message=>"Failed connection to wardrobe/edit json, a wardrobe cannot be found by that authentication_token."}
      end
    else
      logger.info("Failed connection to wardrobe/edit json, no authentication token posted.")
      render :status=>400,
            :json=>{:message=>"Did you add the wardrobe's authentication_token?"}
      return
    end
  end

  def match
    if params[:authentication_token] == nil || params[:temperature] == nil ||
      params[:base_clothing] == nil

      logger.info("Failed connection to wardrobe/matches json, no authentication token posted.")
      render :status=>400,
            :json=>{:message=>"Did you forget the authentication_token,temperature,\
              base_clothing"}
    else
      if Wardrobe.find_by_authentication_token(authentication_token = params[:authentication_token])
        wardrobe = Wardrobe.find_by_authentication_token(authentication_token = params[:authentication_token])
       
       formatter = PreJavaFormatter.new(params[:temperature],params[:base_clothing],
          wardrobe.wardrobe[:tops], wardrobe.wardrobe[:bottoms])
        
        javaParams = formatter.formatJavaParams
        javaParams.each do |param|
          logger.info(param)
          v = `java -cp ./java_algos ScoringAlgo #{param}`
          logger.info(v)
        end
        render :status => 200,
               :json => wardrobe.wardrobe
      else
        logger.info("Failed connection to wardrobe/matches json, a wardrobe cannot be found by that authentication_token.")
        render :status =>400,
               :json=>{:message=>"Failed connection to wardrobe/edit json, a wardrobe cannot be found by that authentication_token."}
      end
    # else
    #   v = `java NaiveAlgo #{params[:color].downcase.capitalize} #{params[:style].downcase.capitalize}`
    #   logger.info("Successful connection to Naive Algorithm.")
    #   render :status => 200,
    #          :json => create_match_json(v.split(",\n"), params[:style])
    end
  end

  private
  def create_match_json(array, style)
    @json = {"original_clothing_category" => style,
            "outfit_pairings"=> []
            }
    array.each do |matches|
      @json["outfit_pairings"] << {"top" => matches.split(",").first, "bottom" => matches.split(",").second}
    end
    return @json
  end
end