class CommentsController < ApplicationController
	before_action :authenticate_user!

	def create
		@photo = Photo.find(params[:photo_id])
		@comment = Comment.create(params[:comment].permit(:content))
		@comment.user_id = current_user.id
		@comment.photo_id = @photo.id

		if @comment.save
			redirect_to photo_path(@photo)
		else
			render 'new'
		end
	end

	def destroy
		@photo = Photo.find(params[:photo_id])
		@comment = @photo.comments.find(params[:id])

		if @comment.user == current_user
			@comment.destroy
		else
			redirect_to root_path, notice: "You are not create that comment so you can't delete it, SORRY!!"
		end

		redirect_to photo_path(@photo)
	end
end
