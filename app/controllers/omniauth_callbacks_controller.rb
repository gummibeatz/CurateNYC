class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    omniauth = request.env["omniauth.auth"]
    user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in(:user, user)
    session[:user_id] = user.id
    redirect_to wardrobe_index_path(user.id), :notice => "Signed in!"    
  end
end