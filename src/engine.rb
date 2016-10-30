# Frice engine base class

require 'tk'
# require ''
require 'pathname'
require_relative 'utils'
require_relative 'objects'
require_relative 'texts'

class Game
	include FriceUtils
	attr_accessor :refresh_per_second, :game_title
	attr_reader :root

	def initialize
		# TkRoot.methods.each { |a|
		# 	p a
		# }
		@refresh_per_second = 100
		@objs = []
		@texts = []
		@timers = []
		@game_title = 'Frice engine'
		@game_bounds = [100, 100, 500, 500]
		on_init
		tk_initialize_information = <<END
title '#{@game_title}'
width #{@game_bounds[2]}
height #{@game_bounds[3]}
END
		@root = TkRoot.new do
			p tk_initialize_information
			eval tk_initialize_information
		end
		@canvas = TkCanvas.new @root
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

	def bounds(x, y, width, height)
		@game_bounds[0] = x
		@game_bounds[1] = y
		@game_bounds[2] = width
		@game_bounds[3] = height
	end

	def size(width, height)
		@game_bounds[2] = width
		@game_bounds[3] = height
	end

	def title(value)
		@game_title = value
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
			raise TypeNotMatchedException.new 'AbstractObject', obj
		end
	end

end
