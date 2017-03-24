require_relative 'journey'
# an intermediary between oystercard and journey classes
class JourneyLog

  attr_reader :journey_class, :journey_history

  def initialize(inputclass = Journey)
    @journey_class = inputclass
    @journey_history = []
  end

  def begin(station)
    journey = journey_class.new
    journey.start(station)
    journey_history << journey
    journey
  end

  def end(station)
    journey = current_journey.finish(station)
    journey_history << journey
    journey.fare
  end

  def journeys
    journey_history.dup
  end

  def in_journey?
    return false if journeys.empty?
    journeys[-1].current_trip.values.include? nil
  end

  private

  def current_journey
    return journey_class.new if journey_history.empty?
    (journey_history[-1].current_trip.values.include? nil) ? journey_history.pop : journey_class.new
  end

  attr_writer :journey_class

end
