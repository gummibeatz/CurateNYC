class Api::V1::WardrobeController < Api::ApiController
  include ActionController::MimeResponds
  respond_to :json

  def index
    if params[:authentication_token] != nil
      if User.find_by_authentication_token(authentication_token = params[:authentication_token])
        @user = User.find_by_authentication_token(authentication_token = params[:authentication_token])
        tops = @user.tops
        bottoms = @user.bottoms
        wardrobe = []
        wardrobe.push(tops).push(bottoms)
        logger.info("Successful #{@user.name} connection to wardrobe json.")
        render :status =>200,
               :json=>wardrobe
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
      @user = User.find_by_authentication_token(authentication_token = params[:authentication_token])
      if @user
        @wardrobe = params[:wardrobe]
        puts file_name = @wardrobe["clothing"]["file_name"]
        @user.tops.append(Top.where(file_name: file_name))
        @user.bottoms.append(Bottom.where(file_name: file_name))
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
      if @user = User.find_by_authentication_token(authentication_token = params[:authentication_token])
        temp = params[:temperature]
        base_clothing = params[:base_clothing]
        color_translator = ColorTranslator.new()
        
        formatter = PreJavaFormatter.new(params[:temperature],params[:base_clothing],
          @user.tops, @user.bottoms, color_translator)
        javaParams = formatter.formatJavaParams
        puts "javaParams = #{javaParams}"
        base_clothing = Top.where(file_name: params[:base_clothing]).first || Bottom.where(file_name: params[:base_clothing]).first
        javaRunner = JavaRunner.new(javaParams, base_clothing, @user.tops, 
          @user.bottoms, color_translator)
        results = javaRunner.run
        formatter = PostJavaFormatter.new(results, base_clothing)
        
        if results.eql? "NA"
          render :status=>200,
                 :json=>{:matches => "NA", :message => "NA"}
        else
          matches = {:matches => formatter.create_outfits, :message => "Success"}
        
          render :status=>200,
                 :json=>matches
        end
      else
        logger.info("Failed connection to wardrobe/matches json, a wardrobe cannot be found by that authentication_token.")
        render :status=>400,
               :json=>{:message=>"Failed connection to wardrobe/edit json, a wardrobe cannot be found by that authentication_token."}
      end
    end
  end

end
