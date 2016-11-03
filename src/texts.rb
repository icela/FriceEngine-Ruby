# game texts and buttons, etc

require_relative 'objects'

class FText < AbstractObject
	attr_accessor :text

	def initialize(text = '')
		@text = text
	end
end

class SimpleText < FText
	attr_accessor :x,
	              :color,
	              :y

	# noinspection RubyInstanceVariableNamingConvention
	def initialize(x, y, text = '', color = 'blue')
		@color = color
		@text = text
		@x = x
		@y = y
	end
end


