class RandomsController < ApplicationController

def different
	@random_photo = Photo.where.not(id: @photo).order("RANDOM()").first
end

end
