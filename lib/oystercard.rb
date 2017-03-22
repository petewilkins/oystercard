#Card used for TFL travel
class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  attr_reader :balance, :journey, :journey_history

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(amount)
    fail "Top up unsuccessful: Balance cannot exceed £#{MAXIMUM_BALANCE}." if balance + amount > MAXIMUM_BALANCE
    self.balance += amount
  end

  def in_journey?
    !!journey
  end

  def touch_in(station)
    fail "Insufficient funds: Please top-up." if insufficient_funds?
    self.journey = {station => nil}
  end

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    journey_history << {journey.keys[0] => station}
    end_journey
  end

  private
  attr_writer :balance, :journey

  def end_journey
    self.journey = nil
  end

  def deduct(amount)
    self.balance -= amount
  end

  def insufficient_funds?
    true if balance < MINIMUM_BALANCE
  end
end
