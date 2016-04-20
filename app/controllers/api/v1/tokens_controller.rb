require 'net/http'
class Api::V1::TokensController  < ApplicationController
    respond_to :json
    def create
      @token = params[:token]
      if request.format != :json
        render :status=>406, :json=>{:message=>"The request must be json my brony"}
        return
       end
 
      if @token.nil?
        logger.info("User #{@token} failed signin, user cannot be found.")
        render :status=>400,
               :json=>{:message=>"Yo man this is nil yo"}
        return
      else
        facebook_feed = fb_oauth_search(@token)
        fb_uid = facebook_feed.body.split("{\"id\":\"").second.split("\"").first
        fb_name = facebook_feed.body.split("\"name\":\"").second.split("\"").first
        fb_email = facebook_feed.body.split("\"email\":\"").second.split("\"").first.gsub("\\u0040","@")
        fb_gender = facebook_feed.body.split("\"gender\":\"").second.split("\"").first
        auth = create_auth(fb_uid, fb_email, fb_name, fb_gender)
        if User.find_by_uid(uid = fb_uid)
          logger.info("User #{fb_name} succeeded signin, they in da' system yo.")
          render :status=>200,
                 :json=>User.find_by_uid(uid = fb_uid)
          return
        else
          @user = User.from_omniauth(auth)
          @user.save!
          if @user.save!
            render :status=>200,
                   :json=>@user
            return
          else
            render :status=>200,
                   :json=>{:message=>"Bro did not save"}
            return
          end
        end  
      end
    end
 
  def destroy
    render :json=>{:message=>"You've hit the token destroy page"}
    @user=User.find_by_authentication_token(params[:id])
    if @user.nil?
      logger.info("“Token not found.”")
      render :status=>404, :json=>{:message=>"”Invalid token.”"}
    else
      @user.reset_authentication_token!
      render :status=>200, :json=>{:token=>params[:id]}
    end
  end

  private
    def fb_oauth_search(oauth_token)
      url = URI.parse('https://graph.facebook.com/me?&access_token='+oauth_token)
      req = Net::HTTP::Get.new url
      res = Net::HTTP.start(url.host, url.port, 
              :use_ssl => url.scheme == 'https') {|http| http.request req}
      return res
    end

    def create_auth(fb_uid, fb_email, fb_name, fb_gender)
      return {:provider=>"facebook",
              :uid=>fb_uid,
              :info=>
                {:email=>fb_email,
                :name=>fb_name,
                :first_name=>fb_name.split(" ").first,
                :last_name=>fb_name.split(" ").second,
                :image=>"http://graph.facebook.com/"+fb_uid+"/picture",
                :urls=>{:Facebook=>"https://www.facebook.com/app_scoped_user_id/"+fb_uid+"/"},
                :verified=>true},
                :credentials=>
                  {:token=>@token,
                  :expires_at=>1428870900,
                  :expires=>true},
                  :extra=>
                    {:raw_info=>
                      {:id=>fb_uid,
                      :email=>fb_email,
                      :first_name=>fb_name.split(" ").first,
                      :gender=>fb_gender,
                      :last_name=>fb_name.split(" ").second,
                      :link=>"https://www.facebook.com/app_scoped_user_id/"+ fb_uid +"/",
                      :locale=>"en_GB",
                      :name=>fb_name,
                      :timezone=>-5,
                      :updated_time=>DateTime.now.to_date,
                      :verified=>true
                      }
                    }
                  }
    end
end
