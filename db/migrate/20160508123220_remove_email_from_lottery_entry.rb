class RemoveEmailFromLotteryEntry < ActiveRecord::Migration
  def change
    remove_column :lottery_entries, :email, :string
  end
end
