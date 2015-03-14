class AddBillingUrlToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :billing_url, :string
  end
end
