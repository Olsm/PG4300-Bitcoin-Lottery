class Lottery < ActiveRecord::Base

  def update_prize
    result = BlockIo.get_address_balance :addresses => bitcoin_address
    self.prize_amount = result['data']['available_balance']
  end

end
