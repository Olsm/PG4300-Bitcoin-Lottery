class CangeEmailAndBitcoinaddressToStringInLotteryEntries < ActiveRecord::Migration
  def change
    change_column :lottery_entries, :bitcoin_address, :string
    change_column :lottery_entries, :email, :string
  end
end
