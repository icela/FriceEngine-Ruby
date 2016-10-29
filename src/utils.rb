# util codes

class AbstractMethodCallException < NotImplementedError
	def initialize(info)
		super info
	end
end

class Class
	def def_abs(name, *args)
		define_method(name, *args) do |*_|
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
end



