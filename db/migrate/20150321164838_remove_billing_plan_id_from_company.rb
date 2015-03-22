class RemoveBillingPlanIdFromCompany < ActiveRecord::Migration
  def change
    remove_column :companies, :billing_plan_id
  end
end
