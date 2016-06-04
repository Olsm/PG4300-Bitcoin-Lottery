class CreateLotteryFees < ActiveRecord::Migration
  def change
    create_table :lottery_fees do |t|
      t.string :name
      t.decimal :amount
      t.string :address
      t.boolean :default, default: true
    end
    LotteryFee.create :name => 'Transaction Fee', :amount => 0.0001
    LotteryFee.create :name => 'The Water Project', :address => '14xEPWuHC3ybPMfv8iTZZ29UCLTUSoJ8HL', :amount => 1
  end
end
