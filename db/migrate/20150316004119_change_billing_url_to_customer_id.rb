class ChangeBillingUrlToCustomerId < ActiveRecord::Migration
  def change
    rename_column :companies, :billing_url, :stripe_id
  end
end
