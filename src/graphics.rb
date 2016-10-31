# graphics utils and objects

class FLine < AbstractObject
	attr_accessor :x1,
	              :x2,
	              :y1,
	              :y2,
	              :color,
	              :width

	def initialize(x1, y1, x2, y2, color = 'blue', width = 2)
		@x1 = x1
		@x2 = x2
		@y1 = y1
		@y2 = y2
		@width = width
		@color = color
	end
end

class FunctionEffect
	# TODO
end
