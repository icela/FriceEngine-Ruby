# FriceEngine on Ruby/tk

Ruby edition of frice engine is a little different from others(JVM/CLR).
  
It's based on Tk, so it might be a little sluggish :joy:.

# Use

```ruby
require_relative '../src/engine'

class Demo < Game
	def on_init
		# initialize
	end

	def on_last_init
		shape = ShapeObject.new 'rect', 1, 1, 100, 100
		shape.color = 'red'
		text = SimpleText.new 10, 10, 'The deep dark fantasy'
		image = ImageResource.from_file 'fork_you.gif'
		image_o = ImageObject.new image, 300, 300
		add_object shape text image_o
	end
	def on_refresh
	end
end

Demo.new
```

# Contributors

+ [ice1000](https://github.com/ice1000)
