require 'observer'

class Timer
  include Observable
  attr_accessor :thread

  def initialize time = 60
    @started = false
    @finished = false
    @time = time
  end

  def run
    @started = true
    @thread = Thread.new do
      while @time > 0 do
        @time -= 1
        sleep(1)
      end
      changed
      notify_observers
      @finished = true
    end
  end

  def started?
    @started
  end

  def finished?
    @finished
  end
end
