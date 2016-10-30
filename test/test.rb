require_relative '../src/engine'

class Demo < Game
	def on_init
		title 'boy next door'
		size 300, 300
		@ass = FObject.new
		@ass.add_anim 233
	end
end

Demo.new
