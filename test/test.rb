require_relative '../src/engine'

class Demo < Game
	def on_init
		@shit = 0
		title 'boy next door'
		size 300, 300
		@ass = FObject.new
		@ass.add_anim 233
	end

	def on_last_init
		TkcLine.new(@canvas, 5, 5, 100, 100, 'fill' => 'blue', 'width' => 2)
		# message_box 'ah', 'ass we can'
	end

	def on_refresh
		add_object FLine.new(0 + @shit, 5, 100, 100)
		@shit += 0.1
	end
end

Demo.new
