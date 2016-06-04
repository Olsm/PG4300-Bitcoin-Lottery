class AddTransactionIdToLottery < ActiveRecord::Migration
  def change
    add_column :lotteries, :transaction_id, :string
  end
end
