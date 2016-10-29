# util codes

class AbstractMethodCallException < NotImplementedError
  def initialize(info)
    super info
  end
end

module FriceUtils
  def self.def_abs(name, *args)
    define_method(name) do |*args|
      if (name == :initialize)
        message = "abstract method called #{self.class.name}##{name}"
      else
        message = "abstract class #{self.class.name}"
      end
      raise AbstractMethodCallException.new message
    end
  end
end

