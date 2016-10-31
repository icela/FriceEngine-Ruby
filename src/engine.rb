# Frice engine base class

require 'tk'
# require ''
require 'pathname'

# noinspection RubyResolve
def frice_import(name)
	require_relative "../src/#{name}"
end

require_relative '../src/utils/utils'
require_relative '../src/objects'
require_relative '../src/resource'
require_relative '../src/texts'
require_relative '../src/graphics'
require_relative '../src/timer'

class Game
	include FriceUtils
	attr_accessor :refresh_per_second,
	              :game_title,
	              :game_bounds

	attr_reader :root,
	            :canvas

	def initialize
		# TkRoot.methods.each { |a|
		# 	p a
		# }
		# TkCanvas.methods.each { |a| p a }
		@refresh_per_second = 100
		@objs = []
		@texts = []
		@timer_listeners = []
		@game_title = 'Frice Engine'
		@game_bounds = [100, 100, 500, 500]
		on_init
		tk_initialize_information = <<END
title '#{@game_title}'
width #{@game_bounds[2]}
height #{@game_bounds[3]}
END
		@root = TkRoot.new do
			print tk_initialize_information
			eval tk_initialize_information
		end
		# noinspection RubyResolve
		canvas_initialize_information = <<END
place(
'x' => 0,
'y' => 0,
'width' => #{@game_bounds[2]},
'height' => #{@game_bounds[3]}
)
END
		# noinspection RubyResolve
		@canvas = TkCanvas.new(@root) do
			print canvas_initialize_information
			eval canvas_initialize_information
		end
		# super do
		# 	on_init
		# end
		@main_thread = -> do
			println 'thread start'
			loop do
				# println 'thread continuing'
				on_refresh
				draw_everything
				# @canvas.pack
				Tk.update
				sleep (1.0 / @refresh_per_second)
			end
		end
		draw_everything
		on_last_init
		Thread.start do
			@main_thread.call
		end
		println 'engine start'
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

	def message_box(msg = 'information',
	                title = 'Frice Engine',
	                type = 'ok',
	                icon = 'info',
	                detail = '',
	                default = 'ok')
		Tk.messageBox 'type' => type,
		              'icon' => icon,
		              'title' => title,
		              'message' => msg,
		              'detail' => detail,
		              'default' => default
	end

	def draw_everything
		@objs.each do |o|
			# println 'drawing everything'
			if o.is_a? ImageObject
				# TkcImage.new @canvas
			elsif o.is_a? FLine
				TkcLine.new(@canvas, o.x1, o.y1, o.x2, o.y2,
				            'width' => o.width,
				            'fill' => o.color)
				# elsif
			end
		end
		@texts.each do |t|
			# TODO
		end
	end

	def title(value)
		@game_title = value
	end

	def on_init
	end

	def on_last_init
	end

	def on_refresh
	end

	def on_click
	end

	def on_exit
	end

	def add_object(*objs)
		objs.each do |obj|
			check_type obj, AbstractObject
			if obj.is_a? FText
				@texts.push obj
			else
				@objs.push obj
			end
		end
	end

	def remove_object(*objs)
		objs.each do |obj|
			check_type obj, AbstractObject
			if obj.is_a? FText
				@texts.delete obj
			else
				@objs.delete obj
			end
		end
	end

	def clear_objects
		@objs.clear
		@texts.clear
	end

	def add_time_listener(*timers)
		timers.each do |t|
			check_type t, FTimerListener
			@timer_listeners.push t
		end
	end

	def remove_time_listener(*timers)
		timers.each do |t|
			check_type t
			@timer_listeners.delete t
		end
	end

	def clear_time_listeners
		@timer_listeners.clear
	end

	public :initialize,
	       :on_init,
	       :on_click,
	       :on_last_init,
	       :on_refresh,
	       # :bounds,
	       :size,
	       :message_box,
	       :title,
	       :add_object,
	       :add_time_listener,
	       :remove_object,
	       :remove_time_listener,
	       :clear_objects,
	       :clear_time_listeners

	private :draw_everything

end
