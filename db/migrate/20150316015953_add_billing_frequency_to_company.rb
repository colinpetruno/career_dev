class AddBillingFrequencyToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :billing_frequency, :string, null: false, default: "monthly"
  end
end
