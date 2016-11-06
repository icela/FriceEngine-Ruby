# classes have sth 2 do with graphics

require 'tk'
require_relative '../src/objects'

# module ColorResource
# 	def initialize(color)
# 		@color = color
# 	end
# end

class FManager
	@res = {}

	def self.create(path)
	end

	def self.get(path)
		return @res[path].clone if @res.has_key? path
		new = create path
		@res[path] = new
		new.clone
	end
end

class ImageManager < FManager
	def self.create(path)
		ret = TkPhotoImage.new
		ret.file = path
		ret
	end
end

class WebImageManager < FManager
	def self.create(path)
		# TODO
	end
end

class ImageResource
	def self.from_file(path)
		ImageResource.new ImageManager.get(path)
	end

	def self.empty
		TkPhotoImage.new.blank
	end

	def self.from_url(url)
		ImageResource.new WebImageManager.get(url)
	end

	attr_accessor :image,
	              :height,
	              :width

	def initialize(image)
		@image = image
		@width = image.width
		@height = image.height
	end
end

