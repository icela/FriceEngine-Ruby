# util codes

class AbstractMethodCallException < NotImplementedError
	def initialize(info)
		super info
	end
end

class Module
	def def_abs(name)
		define_method(name) do
			if name == :initialize
				message = "abstract method called #{self.class.name}##{name}"
			else
				message = "abstract class #{self.class.name}"
			end
			raise AbstractMethodCallException.new message
		end
	end
end

module FriceUtils
	def check_type(object, expected_type)
		unless object.is_a? expected_type
			raise TypeNotMatchedException.new expected_type.name, object
		end
	end

	def println(*args)
		args.each do |a|
			print a
		end
		print "\n"
	end
end



