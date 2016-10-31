# image utils

require 'tk'

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
