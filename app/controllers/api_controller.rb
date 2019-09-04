require 'net/http'
class ApiController < ApplicationController
	before_action :check, only: [:led, :image]
	protect_from_forgery :except => [:led, :image, :new]
	def led
		color_list = ["red", "blue", "green", "white", "orange", "purple", "yellow_green", "clear"]
		effect_list = ["random", "event", "ripples", "all"]

		#用意されている色かどうかチェック
		if color_list.include?(params[:color]) == false
			render json: { status: 'ERROR', message: 'Error! API doesnt correspondence this color!' }
		end

		#用意されているエフェクトかどうかチェック
		if effect_list.include?(params[:effect]) == false
			render json: { status: 'ERROR', message: 'Error! API doesnt correspondence this effect!' }
		end
		
		if params[:id] != 4
			url = "http://" + Device.find_by(id: params[:id]).url + ".ngrok.io/led/" + params[:color]
			Net::HTTP.get_print(URI.parse(url))
		else
			url = Device.find_by(id: params[:id]).url
			Net::HTTP.get_print(URI.parse(url))

		update

		render json: { status: 'SUCCESS', message: 'Success! API commanded to your IoT device!' }
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

	def new
		#既にデバイステーブルにトークンが保存されているかチェック
		if Device.find_by(token: params[:token]) == nil
			#保存されていなかったら新しくトークンを保存してURLを保存
			device = Device.new
			device.token = params[:token]
			device.url = params[:url]
			device.save
			render json: { status: 'SUCCESS', message: 'Success! Make device date in API database!' }
		end

		update

		#保存されていたらURLのみをアップデート
		device = Device.new(token: params[:token])
		device.url = params[:url]
		device.save
		render json: { status: 'SUCCESS', message: 'Success! Make device date in API database!' }
	end

	private
	def check
		#ユーザーIDが存在するかチェック
		if User.find_by(user_id: params[:user_id]) == nil
			render json: { status: 'ERROR', message: 'Error! Donts find user_id in API database!' }
		end

		#デバイスIDが存在するかチェック
		if Device.find_by(id: params[:id]) == nil
			render json: { status: 'ERROR', message: 'Error! Donts find id in API database!' }
		end

		#ユーザーがそのデバイスを登録しているかチェック
		if DeviceUser.where(user_id: params[:user_id]).pluck(:device_id).include?(params[:id]) == false
			render json: { status: 'ERROR', message: 'Error! You donts registration this device id in API!' }
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
