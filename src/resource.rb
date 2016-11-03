# classes have sth 2 do with graphics

require 'tk'
require_relative '../src/objects'

# module ColorResource
# 	def initialize(color)
# 		@color = color
# 	end
# end

class ImageResource
	def self.from_file(path)
		ret = TkPhotoImage.new
		ret.file = path
		return ImageResource.new ret
	end

	def self.empty
		return TkPhotoImage.new.blank
	end

	# def self.from_url(url)
	# 	TODO
	# end

	attr_accessor :image,
	              :height,
	              :width

	def initialize(image)
		@image = image
		@width = image.width
		@height = image.height
	end
end

