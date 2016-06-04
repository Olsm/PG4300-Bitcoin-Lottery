class ChangeLotteryNullableAttributes < ActiveRecord::Migration
  def change
    change_column_null :lottery_entries, :bitcoin_address, false
    change_column_null :lottery_entries, :amount_charged, false
    change_column_null :lottery_entries, :transaction_id, false
    change_column_null :lottery_entries, :lottery_id, false
    change_column_null :lotteries, :prize_amount, false
    change_column_null :lotteries, :bitcoin_address, false
    change_column_default(:lotteries, :ends_at, nil)
  end
end
