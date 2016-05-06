class MoveUserIdFromLotteryToLotteryEntry < ActiveRecord::Migration
  def self.up
    remove_column :lotteries, :user_id
    add_column :lottery_entries, :user_id, :integer
  end

  def self.down
    remove_column :lotteries, :user_id
    add_column :lottery_entries, :user_id, :integer
  end
end
