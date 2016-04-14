class RemoveEmailAndPasswordFromUserAndChangeBitcoinaddressType < ActiveRecord::Migration

  def up
    remove_column :users, :email, :text
    remove_column :users, :password, :text
    change_column :users, :bitcoinaddress, :string
  end

  def down
    change_column :users, :bitcoinaddress, :text
  end
end
