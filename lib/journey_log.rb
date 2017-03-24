class JourneyLog

  attr_reader :journey_class

  def initialize(inputclass = Journey)
    @journey_class = inputclass
  end

  def start(station)
    journey_class.new
  end

  def current_journey
    @currentjourney ||= journey_class.new
  end

end
