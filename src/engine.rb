# Frice engine base class

require 'tk'
require 'pathname'
require Pathname.new(File.dirname(__FILE__)).realpath + 'utils.rb'

class Game
  include FriceUtils
  def initialize()
    @objs = []
    @texts = []
    @timers = []
  end
  FriceUtils::def_abs :on_init
  FriceUtils::def_abs :on_refresh
end
