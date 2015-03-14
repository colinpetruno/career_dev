class AddExpirationToFundingInstruments < ActiveRecord::Migration
  def change
    add_column :funding_instruments, :expiration_month, :string
    add_column :funding_instruments, :expiration_year, :string
  end
end
