class CreateScheduledPayment < ActiveRecord::Migration
  def change
    create_table :scheduled_payments do |t|
      t.references :company, null: false, unique: true
      t.integer :old_billing_plan_id, null: false
      t.integer :new_billing_plan_id, null: false
      t.decimal :amount, null: false
      t.boolean :completed, null: false,  default: false

      t.timestamps
    end
  end
end
