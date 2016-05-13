class SetDefaultPrizeAmountfInLottery < ActiveRecord::Migration
  def change
    change_column_default :lotteries, :prize_amount, 0
  end
end
