class ChangeUrlToToken < ActiveRecord::Migration
  def change
    rename_column :funding_instruments, :url, :token
  end
end
