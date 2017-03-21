class PhotosController < ApplicationController
	before_action :find_photo, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@photos = Photo.all.order('created_at DESC')
	end

	def new
		@photo = current_user.photos.build
	end

	def create
		@photo = current_user.photos.build(photo_params)
		
		if @photo.save
			redirect_to @photo
		else
			render 'new'
		end
	end

	def show
	end

	def edit
	end

	def update
		if @photo.update(params[:photo].permit(:title))
			redirect_to @photo
		else
			render 'edit'
		end
	end

	def destroy
		@photo.destroy
		redirect_to root_path
	end

	private

	def photo_params
		params.require(:photo).permit(:title, :image)
	end

	def find_photo
		@photo = Photo.find(params[:id])
	end
end
