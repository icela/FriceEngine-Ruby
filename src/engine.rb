# Frice engine base class

require 'tk'
require 'tk/canvas'
# require ''

# noinspection RubyResolve
def frice_import(name)
	require_relative "../src/#{name}"
end

require_relative '../src/utils/utils'
require_relative '../src/timer'
require_relative '../src/anims'
require_relative '../src/objects'
require_relative '../src/resource'
require_relative '../src/texts'
require_relative '../src/graphics'

# noinspection RubyTooManyInstanceVariablesInspection
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
		@objs = [ ]
		@texts = [ ]
		@timer_listeners = [ ]
		@game_title = 'Frice Engine'
		@game_bounds = [100, 100, 500, 500]
		on_init
		@game_timer = FTimer.new @refresh_per_second
		tk_initialize_information = <<END
title '#{@game_title}'
width #{@game_bounds[2]}
height #{@game_bounds[3]}
END
		@root = TkRoot.new do
			print tk_initialize_information
			eval tk_initialize_information
		end
		@canvas = new_canvas
		# super do
		# 	on_init
		# end
		@main_thread = -> do
			println 'thread start'
			loop do
				if @game_timer.ended
					# println 'thread continuing'
					on_refresh
					@timer_listeners.each do |t|
						t.check
					end
					draw_everything
					# @canvas.pack
					Tk.update
				end
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

	def new_canvas
		# noinspection RubyResolve
		canvas_initialize_information = <<END
place(
'x' => 0,
'y' => 0,
'width' => #{@game_bounds[2]},
'height' => #{@game_bounds[3]}
)
END
		# noinspection RubyResolve,RubyUnnecessaryReturnStatement
		return TkCanvas.new(@root) do
			print canvas_initialize_information
			eval canvas_initialize_information
		end
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
		@canvas = new_canvas
		clear_screen
		@objs.each do |o|
			if o.is_a? FObject
				o.run_anims
				# o.check_collision
			end
			# println 'drawing everything'
			if o.is_a? ImageObject
				TkcImage.new @canvas, o.x, o.y,
				             'image' => o.image.image
			elsif o.is_a? FLine then
				TkcLine.new @canvas, o.x1, o.y1, o.x2, o.y2,
				            'width' => o.width,
				            'fill' => o.color
			elsif o.is_a? ShapeObject
				case o.shape
					when 'rectangle', 'rect' then
						TkcRectangle.new @canvas, o.x, o.y, o.width, o.height,
						                 'fill' => o.color
					when 'oval' then
						TkcOval.new @canvas, o.x, o.y, o.width, o.height,
						            'fill' => o.color
					else
						# type code here
				end
			end
		end

		@texts.each do |t|
			if t.is_a? SimpleText
				TkcText.new @canvas, t.x, t.y,
				            'fill' => t.color,
				            'text' => t.text
			end
		end
	end

	def clear_screen
		TkcRectangle.new @canvas, 0, 0,
		                 @game_bounds[2],
		                 @game_bounds[3],
		                 'fill' => 'white'
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
			check_type t, FTimeListener
			@timer_listeners.push t
		end
	end

	def remove_time_listener(*timers)
		timers.each do |t|
			check_type t, FTimeListener
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
	       :clear_time_listeners,
	       :clear_screen

	private :draw_everything,
	        :new_canvas

end
