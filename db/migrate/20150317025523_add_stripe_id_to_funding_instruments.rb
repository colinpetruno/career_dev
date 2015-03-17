class AddStripeIdToFundingInstruments < ActiveRecord::Migration
  def change
    add_column :funding_instruments, :stripe_id, :string, null: false
  end
end
