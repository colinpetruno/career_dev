class AddBillingPlanToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :billing_plan_id, :integer, null: false
  end
end
