require_relative 'journey'
#Card used for TFL travel
class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1
  PENALTY_FARE = 6

  attr_reader :balance, :journeylog

  def initialize
    @balance = 0
    @journeylog = JourneyLog.new
  end

  def in_journey?
    journeylog.in_journey?
  end

  def top_up(amount)
    fail "Top up unsuccessful: Balance cannot exceed £#{MAXIMUM_BALANCE}." if balance + amount > MAXIMUM_BALANCE
    self.balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds: Please top-up." if insufficient_funds?
    charge_penalty if in_journey?
    journeylog.begin(station)
  end

  def touch_out(station)
    if in_journey?
      journeylog.end(station)
      deduct(MINIMUM_CHARGE)
    else
      charge_penalty
    end
  end

  private
  attr_writer :balance

  def charge_penalty
    deduct(PENALTY_FARE)
  end

  def deduct(amount)
    self.balance -= amount
  end

  def insufficient_funds?
    true if balance < MINIMUM_BALANCE
  end
end
