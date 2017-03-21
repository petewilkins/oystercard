#Card used for TFL travel
class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  attr_reader :balance, :in_journey

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Top up unsuccessful: Balance cannot exceed £#{MAXIMUM_BALANCE}." if balance + amount > MAXIMUM_BALANCE
    self.balance += amount
  end


  def in_journey?
    in_journey
  end

  def touch_in
    fail "Insufficient funds: Please top-up." if insufficient_funds?
    self.in_journey = true
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    self.in_journey = false
  end

  private
  attr_writer :in_journey, :balance

  def deduct(amount)
    self.balance -= amount
  end

  def insufficient_funds?
    true if balance < MINIMUM_BALANCE
  end

end
