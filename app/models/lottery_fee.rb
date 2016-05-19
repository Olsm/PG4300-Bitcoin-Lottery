class LotteryFee < ActiveRecord::Base

  has_and_belongs_to_many :lotteries

end
