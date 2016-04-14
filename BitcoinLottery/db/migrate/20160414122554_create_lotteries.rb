class CreateLotteries < ActiveRecord::Migration
  def change
    create_table :lotteries do |t|
      t.integer :lottery_id
      t.decimal :prize_amount
      t.integer :user_id
      t.string :bitcoin_address

      t.timestamps null: false
    end
  end
end
