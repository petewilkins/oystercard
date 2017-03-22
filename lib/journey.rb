#we are adding journeys, completing journeys and knowing if a journey is incomplete
#decides if penalty fare is necessary
class Journey
  attr_reader :current_trip

  def initalize
    @current_trip = {}
  end

  def in_journey?
    !!current_trip
  end

  def start(entry_station)
    self.current_trip = {entry_station => nil}
  end

  def finish(exit_station)
    #penalty fare unless in_journey?
    self.current_trip = {current_trip.keys[0] => exit_station}
  end

  def penalty_fare?

  end

  # def fare
  #   if penalty_fare?
  #     MINIMUM_CHARGE + 6
  #   else
  #     MINIMUM_CHARGE
  #   end
  # end

  private

  attr_writer :current_trip

end
