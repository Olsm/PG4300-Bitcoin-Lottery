class LotteryEntry < ActiveRecord::Base

  after_commit do
    lottery = Lottery.find_by id: lottery_id
    lottery.update_prize
  end

end
