# util codes

class AbstractMethodCallException < NotImplementedError
  def initialize(info)
    super info
  end
end

module Frice
  def def_abs(name, &block)
    raise AbstractMethodCallException.new (
            "abstract method called #{self.class.name}##{name}"
          )
  end
end

