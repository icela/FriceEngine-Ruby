# animation classes

class FAnim
end

class MoveAnim < FAnim
	attr_accessor :x,
	              :y

	# noinspection RubyInstanceVariableNamingConvention
	def initialize(x, y)
		@x = x
		@y = y
	end
end

class ScaleAnim < FAnim
end

class RotateAnim < FAnim
end

class SimpleMove < MoveAnim
end

class AccelerateMove < MoveAnim
end
