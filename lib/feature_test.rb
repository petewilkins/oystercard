require './lib/oystercard'

card = Oystercard.new
card.top_up(5)
card.deduct(2)
card.balance
card.touch_in
card.touch_out
card.balance
