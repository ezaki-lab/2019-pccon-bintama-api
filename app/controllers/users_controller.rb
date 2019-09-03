class UsersController < ApplicationController
	before_action :authenticate_user, only: [:index]
	def index
		@user = User.find_by(user_id: session[:user_id])
		devices = DeviceUser.where(user_id: session[:user_id]).pluck(:device_id)
		@device = Device.where(id: devices).pluck(:id, :token, :url, :updated_at)
	end
end
