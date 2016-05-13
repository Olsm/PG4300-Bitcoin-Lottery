class AddTransactionIdToLotteryEntry < ActiveRecord::Migration
  def change
    add_column :lottery_entries, :transaction_id, :string
  end
end
