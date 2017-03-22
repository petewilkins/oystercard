require './lib/oystercard'
card = Oystercard.new
card.top_up(30)
card.touch_in("Banana")
