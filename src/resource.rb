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
		ImageResource.new ret
	end

	# def self.from_url(url)
	# 	TODO
	# end

	attr_accessor :image

	def initialize(image)
		@image = image
	end
end

