class PhotosController < ApplicationController
	before_action :find_photo, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@photos = Photo.all.order('created_at DESC').paginate(page: params[:page], per_page: 2)
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
		@comments = Comment.where(photo_id: @photo)
	end

	def edit
	end

	def update
		if @photo.update(photo_params)
			redirect_to @photo, notice: 'Good Job!'
		else
			render 'edit'
		end
	end

	def destroy
		@photo.destroy
		redirect_to root_path, notice: 'Why are you doing that?'
	end

	def upvote
		@photo.upvote_by current_user
		redirect_to :back
	end

	def downvote
		@photo.downvote_by current_user
		redirect_to :back
	end

	def toprated
		@top_photos = Photo.all.order(:cached_votes_up => :desc)
	end

	def random
		@random_photo = Photo.where.not(id: @photo).order("RANDOM()").first
	end

	private

	def photo_params
		params.require(:photo).permit(:title, :image)
	end

	def find_photo
		@photo = Photo.find(params[:id])
	end
end
