# Frice engine base class

require 'tk'
require 'pathname'
require_relative 'utils'
require_relative 'objects'
require_relative 'texts'

class Game
	include FriceUtils
	attr_accessor :refresh_per_second


	def initialize
		@refresh_per_second = 100
		@objs = []
		@texts = []
		@timers = []
		@root = TkRoot.new
		on_init
		# super do
		# 	on_init
		# end
		@main_thread = Thread.new do
			loop do
				sleep @refresh_per_second
				on_refresh
				Tk.update
			end
		end
		@main_thread.run
		Tk.mainloop
	end

	def on_init
	end

	def on_refresh
	end

	def on_click
	end

	def on_exit
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
