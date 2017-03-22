require_relative 'journey'
#Card used for TFL travel
class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  attr_reader :balance, :journey_history, :journey

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(amount)
    fail "Top up unsuccessful: Balance cannot exceed £#{MAXIMUM_BALANCE}." if balance + amount > MAXIMUM_BALANCE
    self.balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds: Please top-up." if insufficient_funds?
    @journey = Journey.new
    journey.start(station)
  end

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    journey.finish(station)
    journey_history << journey.current_trip
  end

  private
  attr_writer :balance, :journey

  def deduct(amount)
    self.balance -= amount
  end

  def insufficient_funds?
    true if balance < MINIMUM_BALANCE
  end
end
