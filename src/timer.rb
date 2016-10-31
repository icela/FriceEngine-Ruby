# timers


class FTimer
	def initialize(time)
		@time = time
	end

	def ended
	end
end

class FTimeListener < FTimer
	def initialize(time, &event)
		super time
		@event = event
	end

	def check
		@event.call if ended
	end
end


