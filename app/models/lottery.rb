class Lottery < ActiveRecord::Base

  def update_prize
    result = BlockIo.get_address_balance :addresses => bitcoin_address
    self.prize_amount = result['data']['available_balance']
  end

  def get_lottery_entries
    LotteryEntry.where(lottery_id = id)
  end

end
