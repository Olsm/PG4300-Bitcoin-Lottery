class AddEndsAtToLottery < ActiveRecord::Migration
  def up
    add_column :lotteries, :ends_at, :datetime
    change_column_null :lotteries, :ends_at, false
  end

  def down
    remove_column :lotteries, :ends_at, :datetime
  end
end
