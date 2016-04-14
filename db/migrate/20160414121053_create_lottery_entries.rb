class CreateLotteryEntries < ActiveRecord::Migration
  def change
    create_table :lottery_entries do |t|
      t.text :email
      t.text :bitcoin_address
      t.decimal :amount_charged

      t.timestamps null: false
    end
  end
end
