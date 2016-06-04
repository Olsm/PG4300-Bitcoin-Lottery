class SetBitcoinAddressNullable < ActiveRecord::Migration
  def change
    change_column_null :lotteries, :bitcoin_address, true
  end
end
