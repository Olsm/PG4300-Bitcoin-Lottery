class AddColumnQrCodeToLotteries < ActiveRecord::Migration
  def change
    add_column :lotteries, :qr_code, :string
  end
end
