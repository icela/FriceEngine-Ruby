# Frice engine base class

require 'tk'
require 'utils.rb'

class Game < Frice
  def initialize()
    @objs = []
    @texts = []
    @timers = []
  end
  def _on_init()
  end
  def _on_refresh()
  end
end
