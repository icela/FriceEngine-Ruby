# timers

class Clock
	@started = true
	@start_ticks = Time.now.to_f * 1e3
	@pause_ticks = @start_ticks

	def self.pause
		unless @started
			return
		end
		@pause_ticks = Time.now.to_f
		@started = false
	end

	def self.resume
		if @started
			return
		end
		@start_ticks += Time.now.to_f * 1e3
		@started = true
	end

	# System.currentTimeMillis() :joy:
	def self.current
		return @started ? Time.now.to_f * 1e3 - @start_ticks : @pause_ticks - @start_ticks
	end
end

class FTimer
	def initialize(time)
		@time = time
		@start = Clock.current
	end

	def ended
		if Clock.current - @start > @time
			@start = Clock.current
			true
		else
			false
		end
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


