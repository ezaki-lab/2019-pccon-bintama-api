class ApplicationController < ActionController::Base
  def authenticate_user
		if session[:user_id] == nil
			flash[:notice] = "ログインしてください"
      redirect_to "/user_login"
		end
  end
end
