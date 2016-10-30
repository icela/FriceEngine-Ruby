require_relative '../src/engine'

class Demo < Game
	def on_init
		title 'boy next door'
		size 300, 300
		@ass = FObject.new
		@ass.add_anim 233
	end

	def on_last_init
		message_box 'ah', 'ass we can'
	end


end

Demo.new
