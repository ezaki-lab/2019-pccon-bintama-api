require 'net/http'
class ApiController < ApplicationController
	before_action :check, only: [:led, :image]
	protect_from_forgery :except => [:led, :image, :new, :place_new]
	def led
		color_list = ["red", "blue", "green", "white", "yellow", "purple", "skyblue", "clear"]

		#用意されている色かどうかチェック
		if color_list.include?(params[:color]) == false
			render json: { status: 'ERROR', message: 'Error! API doesnt correspondence this color!' }
		else
			if params[:id] != 4
				url = "http://" + Device.find_by(id: params[:id]).url + ".ngrok.io/led/" + params[:color]
				Net::HTTP.get_print(URI.parse(url))
			else
				url = Device.find_by(id: params[:id]).url
				Net::HTTP.get_print(URI.parse(url))
			end
	
			update
			render json: { status: 'SUCCESS', message: 'Success! API commanded to your IoT device!' }
		end

	end

	def image
		url = "http://" + Device.find_by(id: params[:id]).url + ".ngrok.io/image/" + params[:path] + "/" + params[:second].to_s
		Net::HTTP.get_print(URI.parse(url))

		update

		render json: { status: 'SUCCESS', message: 'Success! API commanded to your IoT device!' }
	end

	def place
		#デバイスIDが存在するかチェック
		if DevicePlace.find_by(id: params[:id]) == nil
			render json: { status: 'ERROR', message: 'Error! Donts find id in API database!' }
		else
			update
			render json: { status: 'SUCCESS', message: 'Success! This device’s place data.', latitude: DevicePlace.find_by(device_id: params[:id]).latitude, longitude: DevicePlace.find_by(device_id: params[:id]).longitude }
		end
	end

	def place_new
		if DevicePlace.find_by(id: params[:id])
			update
			new_place = DevicePlace.find_by(id: params[:id])
			new_place.longitude = params[:longitude]
			new_place.latitude = params[:latitude]
			new_place.save
			render json: { status: 'SUCCESS', message: 'Success! Make device place date in API database!' }
		else
			new_place = DevicePlace.new
			new_place.device_id = params[:id]
			new_place.longitude = params[:longitude]
			new_place.latitude = params[:latitude]
			new_place.save
			render json: { status: 'SUCCESS', message: 'Success! Make device place date in API database!' }
		end
	end

	def new
		#既にデバイステーブルにトークンが保存されているかチェック
		if Device.find_by(token: params[:token]) == nil
			#保存されていなかったら新しくトークンを保存してURLを保存
			device = Device.new
			device.token = params[:token]
			device.url = params[:url]
			device.save
			render json: { status: 'SUCCESS', message: 'Success! Make device date in API database!' }
		else
			#保存されていたらURLのみをアップデート
			device = Device.find_by(token: params[:token])
			device.url = params[:url]
			device.save
			render json: { status: 'SUCCESS', message: 'Success! Make device date in API database!' }
		end
	end

	def show
		if User.find_by(user_id: params[:user_id])
			device_list = []
			device = DeviceUser.where(user_id: params[:user_id]).all
			device.each do |f|
				device_list.push(f.device_id)
			end
			render json: { status: 'SUCCESS', device_list: device_list }
		else
			render json: { status: 'ERROR', message: 'Error! Donts find id in API database!' }
		end
	end

	def id
		if Device.find_by(token: params[:token])
			render json: { status: 'SUCCESS', id: Device.find_by(token: params[:token]).id }
		else
			render json: { status: 'ERROR', message: 'Error! Donts token id in API database!' }
		end
	end

	private
	def check
		#ユーザーIDが存在するかチェック
		if User.find_by(user_id: params[:user_id]) == nil
			render json: { status: 'ERROR', message: 'Error! Donts find user_id in API database!' }
		elsif Device.find_by(id: params[:id]) == nil
			render json: { status: 'ERROR', message: 'Error! Donts find id in API database!' }
		#elsif DeviceUser.where(user_id: params[:user_id]).pluck(:device_id).include?(params[:id]) == true
		#	render json: { status: 'ERROR', message: 'Error! You donts registration this device id in API!' }
		end
	end

	def update
		if Device.find_by(id: params[:id])
			new_date = Device.find_by(id: params[:id])
			new_date.updated_at = Time.new
			new_date.save
		end
	end
end
