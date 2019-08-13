class MainController < ApplicationController
	def index
		if session[:user_id] != nil
			flash[:notice] = "ようこそ、" + session[:user_id] + "さん！"
		end
  end
end
