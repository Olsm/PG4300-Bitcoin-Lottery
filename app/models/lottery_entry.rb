class LotteryEntry < ActiveRecord::Base
  after_commit :update_price

  belongs_to :lottery

  def update_price
    lottery.update_prize
  end

end
