require_relative 'utils'

class TypeNotMatchedException < RuntimeError
	def initialize(info)
		super info
	end
end

# noinspection RubyInstanceVariableNamingConvention
class AbstractObject
	def initialize
		@x = 0
		@y = 0
		@rotate = 0
	end
end

class FContainer
	# noinspection RubyInstanceVariableNamingConvention
	def initialize
		@x = 0
		@y = 0
	end
	def contains_point(px, py)
		px >= @x && px <= @x + width && py >= @y && py <= @y + height
	end
	alias :contains :contains_point
end

class CollideBox < FContainer
	def_abs :is_collide, :other
end







