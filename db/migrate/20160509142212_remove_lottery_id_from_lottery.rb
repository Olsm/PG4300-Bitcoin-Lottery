class RemoveLotteryIdFromLottery < ActiveRecord::Migration
  def change
    remove_column :lotteries, :lottery_id, :integer
  end
end
