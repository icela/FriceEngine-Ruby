require_relative 'utils/utils'
require_relative 'image'

class TypeNotMatchedException < RuntimeError
	def initialize(required, given)
		super "required a #{required}, given #{given.class.name}"
	end
end

# noinspection RubyInstanceVariableNamingConvention
class AbstractObject
	include FriceUtils
	attr_accessor :x, :y, :rotate

	def initialize
		@x = 0
		@y = 0
		@rotate = 0
	end
end

module FContainer
	attr_accessor :x, :y, :width, :height

	# noinspection RubyInstanceVariableNamingConvention
	def initialize
		@x = 0
		@y = 0
		@width = 1
		@height = 1
	end

	def contains_point(px, py)
		px >= @x && px <= @x + width && py >= @y && py <= @y + height
	end

	alias :contains :contains_point
end

module CollideBox
	def_abs :is_collide
end

class PhysicalObject < AbstractObject
	include FContainer
	include CollideBox
	attr_accessor :mass, :died

	def initialize
		super
		@died = false
		@mass = 1
	end

	def mass=(value)
		value = 1e-3 if value <= 1e-3
		@mass = value
	end
end

class FObject < PhysicalObject
	attr_reader :force, :targets, :anims

	def initialize
		@anims = []
		@targets = []
		# TODO achieve moves
		@force = nil
		@collide_box = nil
	end

	def add_anim(*anims)
		@anims.insert anims
	end

	def remove_anim(*anims)
		@anims.delete anims
	end

	# noinspection RubyInstanceVariableNamingConvention
	def move(px, py)
		@x += px
		@y += py
	end

	def rotate(angle)
		@rotate += angle
	end

	def collide_rect(rect)
		unless rect is_a? PhysicalObject
			raise TypeNotMatchedException.new 'PhysicalObject', rect
		end
		@x + @width >= rect.x and
				rect.y <= @y + @height and
				@x <= rect.x + rect.width and
				@y <= rect.y + rect.height
	end
end

# a = FObject.new

class ImageObject < FObject
	attr_accessor :image

	def initialize(image)
		check_type image, ImageResource
		@image = image
	end
end


