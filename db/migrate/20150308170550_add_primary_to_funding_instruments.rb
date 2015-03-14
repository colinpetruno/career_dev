class AddPrimaryToFundingInstruments < ActiveRecord::Migration
  def change
    add_column :funding_instruments, :primary, :boolean, null: false, default: false
  end
end
