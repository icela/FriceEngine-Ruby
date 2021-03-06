# object models

require_relative '../src/resource'
require_relative '../src/anims'
require_relative '../src/utils/utils'

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
	attr_accessor :rotate,
	              :x,
	              :y,
	              :height,
	              :width

	attr_reader :force,
	            :targets,
	            :anims


	def initialize
		super
		@anims = [ ]
		@targets = { }
		# TODO achieve moves
		@force = nil
		@collide_box = nil
	end

	def run_anims
		@anims.each do |anim|
			if anim.is_a? MoveAnim
				x, y = anim.delta
				# p 'in object.rb', x, y
				move x, y
			end
		end
	end

	def check_collision
		@targets.each do |tgt|
			# TODO
		end
	end

	def add_anim(*anims)
		anims.each do |anim|
			check_type anim, FAnim
			@anims.push anim
		end
	end

	def remove_anim(*anims)
		anims.each do |anim|
			check_type anim, FAnim
			@anims.delete anims
		end
	end

	def clear_anim
		@anims.clear
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
		check_type rect, PhysicalObject
		@x + @width >= rect.x and
				rect.y <= @y + @height and
				@x <= rect.x + rect.width and
				@y <= rect.y + rect.height
	end

	public :add_anim,
	       :remove_anim,
	       :clear_anim,
	       :move,
	       :rotate,
	       :run_anims,
	       :check_collision

	protected :collide_rect
end

# a = FObject.new

class ImageObject < FObject
	attr_accessor :image,
	              :x,
	              :y

	# noinspection RubyInstanceVariableNamingConvention
	def initialize(image, x, y)
		super()
		check_type image, ImageResource
		@image = image
		@x = x
		@y = y
	end
end

class ShapeObject < FObject
	attr_accessor :shape,
	              :color,
	              :height,
	              :width,
	              :x,
	              :y

	# noinspection RubyInstanceVariableNamingConvention
	def initialize(shape, color = 'blue', x, y, width, height)
		super()
		@shape = shape
		@color = color
		@x = x
		@y = y
		@width = width
		@height = height
	end
end



