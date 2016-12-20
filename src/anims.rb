# animation classes

require_relative '../src/timer'
require_relative '../src/utils/utils'

class FAnim
	def initialize
		@start = Clock.current
	end
end

class MoveAnim < FAnim
	def initialize
		super
		@last_refresh = @start
	end

	def delta
		raise NotImplementedError.new
	end
end

class ScaleAnim < FAnim
end

class RotateAnim < FAnim
end

class SimpleMove < MoveAnim
	attr_accessor :x,
	              :y

	# noinspection RubyInstanceVariableNamingConvention
	def initialize(x, y)
		super()
		@x = x
		@y = y
	end

	def delta
		dt = Clock.current - @last_refresh
		@last_refresh = Clock.current
		[dt * @x / 1e3, dt * @y / 1e3]
	end
end

class AccelerateMove < MoveAnim
	def initialize(x, y)
		super()
		@x = x
		@y = y
	end

	def delta
		#
	end
end
