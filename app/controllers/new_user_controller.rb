class NewUserController < ApplicationController
def index
  @new_user = User.new
end
        
def create
  @user = User.new(users_params)

  if @user.save
    redirect_to "/user_login"
  else
    flash[:notice] = "入力された値に間違いがあります。"
    redirect_to "/new_user/"
  end
        
end
        
private
def users_params
  params.require(:user).permit(:user_id, :email, :password, :password_confirmation)
end

end
