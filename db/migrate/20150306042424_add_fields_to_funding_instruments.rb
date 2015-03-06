class AddFieldsToFundingInstruments < ActiveRecord::Migration
  def change
    add_column :funding_instruments, :name,           :string
    add_column :funding_instruments, :account_type,   :string
    add_column :funding_instruments, :description,    :string
    add_column :funding_instruments, :account_number, :string
  end
end
