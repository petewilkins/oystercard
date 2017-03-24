require_relative 'journey'

class JourneyLog

  attr_reader :journey_class, :journeys

  def initialize(inputclass = Journey)
    @journey_class = inputclass
    @journeys = []
  end

  def begin(station)
    journey = journey_class.new
    journey.start(station)
    journeys << journey
    journey
  end

  def current_journey
    return journey_class.new if journeys.empty?
    (journeys[-1].current_trip.values.include? nil) ? journeys.pop : journey_class.new
  end

  attr_writer :journey_class

end
