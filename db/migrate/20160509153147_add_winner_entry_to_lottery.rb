class AddWinnerEntryToLottery < ActiveRecord::Migration
  def change
    add_column :lotteries, :winner_entry, :integer
  end
end
