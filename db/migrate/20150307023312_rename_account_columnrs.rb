class RenameAccountColumnrs < ActiveRecord::Migration
  def change
    rename_column :funding_instruments, :account_number, :number
  end
end
