class CreateSubscription < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :company_id, null: false
      t.integer :billing_plan_id, null: false
      t.boolean :active, null: false, default: true
      t.datetime :end_date

      t.timestamps
    end
  end
end
