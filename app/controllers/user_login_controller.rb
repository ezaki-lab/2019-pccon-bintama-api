class UserLoginController < ApplicationController
  def index
    @login_user = User.new
  end

  def create
    @login_user = User.new
		@user = User.find_by(user_id: params[:user][:user_id])

    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.user_id
      flash[:notice] = "ようこそ、" + session[:user_id] + "さん！"
      redirect_to "/main"
  	else
      flash[:notice] = "ユーザーIDもしくはパスワードが間違っています。"
      redirect_to "/user_login"
    end
  end
end
