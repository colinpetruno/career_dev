class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :billing_plan, null: false
      t.references :company, null: false
      t.string :stripe_id, null: false
      t.string :frequency, null: false, default: "monthly"
      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
