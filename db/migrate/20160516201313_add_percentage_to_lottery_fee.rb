class AddPercentageToLotteryFee < ActiveRecord::Migration
  def change
    add_column :lottery_fees, :percentage, :boolean, default: true
    LotteryFee.first.update percentage: false
  end
end
