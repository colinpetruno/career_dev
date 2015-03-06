class AddFeaturedToBillingPlan < ActiveRecord::Migration
  def change
    add_column :billing_plans, :featured, :boolean, null: false, default: false
  end
end
