class CreateLotteriesLotteryFeesJoinTable < ActiveRecord::Migration
  def change
    create_table :lotteries_lottery_fees, id: false do |t|
      t.integer :lottery_id
      t.integer :lottery_fee_id
    end

    add_index :lotteries_lottery_fees, :lottery_id
    add_index :lotteries_lottery_fees, :lottery_fee_id
  end
end
