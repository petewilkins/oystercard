require_relative 'journey'
#Card used for TFL travel
class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  PENALTY_FARE = 6

  attr_reader :balance, :journey_history, :journey

  def initialize
    @balance = 0
    @journey_history = []
  end

  def in_journey?
    !!journey
  end

  def top_up(amount)
    fail "Top up unsuccessful: Balance cannot exceed £#{MAXIMUM_BALANCE}." if balance + amount > MAXIMUM_BALANCE
    self.balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds: Please top-up." if insufficient_funds?
    deduct(PENALTY_FARE) if in_journey?
    self.journey = Journey.new #can we change this to self.journey
    journey.start(station)
  end

  def touch_out(station)
    if in_journey?
      journey.finish(station)
      journey_history << journey.current_trip
      self.journey = nil
    else
      puts "Penalty Fare Deducted"
      deduct(PENALTY_FARE)
    end
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
