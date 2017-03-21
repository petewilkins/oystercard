require './lib/oystercard'

card = Oystercard.new
card.top_up(5)
card.deduct(5)
card.balance
card.touch_in
