class RemoveQrCodeAndStatusFromLottery < ActiveRecord::Migration
  def change
    remove_column :lotteries, :qr_code, :string
    remove_column :lotteries, :status, :string
  end
end
