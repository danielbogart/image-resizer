class ImageFile < ActiveRecord::Base
	attr_accessor :png_file, :width_offset, :height_offset

	validates :name, presence: true
	validates :name, uniqueness: true

end
