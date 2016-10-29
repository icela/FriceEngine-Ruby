# Frice engine base class

require 'tk'
require 'pathname'
require_relative 'utils'
require_relative 'objects'

class Game
	include FriceUtils

	def initialize
		@objs = []
		@texts = []
		@timers = []
	end

	def on_init
	end

	def on_refresh
	end

	def add_object(obj)
		if obj is_a? FText
			@texts += obj
		elsif obj is_a? AbstractObject
			@objs += obj
		else
			raise TypeNotMatchedException.new "required an AbstractObject, given #{obj.class.name}"
		end
	end

end
