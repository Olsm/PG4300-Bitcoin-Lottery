class Lottery < ActiveRecord::Base

  has_many :entries, class_name: 'LotteryEntry'

  def update_prize
    result = BlockIo.get_address_balance :addresses => bitcoin_address
    self.prize_amount = result['data']['available_balance']
    self.save

  end

end