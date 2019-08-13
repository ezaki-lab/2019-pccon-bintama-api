class NewDeviceController < ApplicationController
	def index
	end

	def new
		@device = Device.new
	end
					
	def create
		@device = Device.find_by(token: params[:device][:token])
		if @device == nil
			flash[:notice] = "そのトークンは存在しません"
			redirect_to "/new_device/new"
		else
			@new_device = DeviceUser.new
			@new_device.user_id = session[:user_id]
			@new_device.device_id = @device.id
			@new_device.save
			flash[:notice] = "デバイス登録完了"
			redirect_to "/new_device"			
		end		
	end
end
