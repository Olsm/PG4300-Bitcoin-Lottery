class AddLotteryIdToLotteryEntry < ActiveRecord::Migration
  def change
    add_column :lottery_entries, :lottery_id, :integer
  end
end
