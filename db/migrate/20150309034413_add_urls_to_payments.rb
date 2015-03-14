class AddUrlsToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :order_url, :string
    add_column :payments, :debit_url, :string
  end
end
