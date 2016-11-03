﻿# FriceEngine on Ruby/tk

Ruby edition of frice engine is a little different from others(JVM/CLR).  

# Use

```ruby
require_relative '../src/engine'

class Demo < Game
	def on_init
		# initialize
	end

	def on_last_init
		shape = ShapeObject.new('rect', 1, 1, 100, 100)
		shape.color = 'red'
		add_object shape
	end
	def on_refresh
	end
end

Demo.new
```

# Contributors

+ [ice1000](https://github.com/ice1000)
