class PhotosController < ApplicationController
	def index
		@photos = Photo.all
	end

	def show
		@photo = Photo.find(params_id)
	end

	def new
		@photo = Photo.new
	end

	def create
		@photo = Photo.new(photo_params)
	end

	private

	def photo_params
		params.require(:photo).permit(:title)
	end
end
