require_relative 'station'
#we are adding journeys, completing journeys and knowing if a journey is incomplete
#decides if penalty fare is necessary
class Journey
  attr_reader :current_trip, :entry_station, :exit_station

  def initalize
    @current_trip = {}
    @entry_station
    @exit_station
  end

  def start(entry_station)
    self.entry_station = entry_station
    self.current_trip = {entry_station => nil}
  end

  def finish(exit_station)
    self.exit_station = exit_station
    self.current_trip = {current_trip.keys[0] => exit_station}
    return self
  end

  def fare
    (entry_station.zone - exit_station.zone).abs
  end

  private

  attr_writer :current_trip, :entry_station, :exit_station

end
