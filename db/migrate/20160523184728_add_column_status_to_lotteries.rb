class AddColumnStatusToLotteries < ActiveRecord::Migration
  def change
    add_column :lotteries, :status, :string
  end
end
