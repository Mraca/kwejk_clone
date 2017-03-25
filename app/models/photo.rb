class Photo < ActiveRecord::Base
	validates :title, presence: true, length: { minimum: 5 }

	has_attached_file :image, styles: { large: "400x600>", medium: "300x300>", thumb: "100x100#" }
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  	belongs_to :user
  	has_many :comments
end
