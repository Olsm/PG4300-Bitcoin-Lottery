class Lottery < ActiveRecord::Base

  has_many :entries, class_name: 'LotteryEntry'

  def update_prize
    result = BlockIo.get_address_balance :addresses => bitcoin_address
    self.prize_amount = result['data']['available_balance']
    self.save
  end

  def end
    self.winner_entry = pick_winner
    #TODO: Send prize to winner
  end

  private

  def pick_winner
    key_func = Proc.new{ |item| item.id }
    weight_func = Proc.new{ |item| item.amount_charged }

    pickup = Pickup.new(entries, key_func: key_func, weight_func: weight_func)
    pickup.pick
  end

end