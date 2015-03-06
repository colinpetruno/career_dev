class CreateBillingPlan < ActiveRecord::Migration
  def change
    create_table :billing_plans do |t|
      t.string :name, null: false
      t.integer :users, null: false, default: 0
      t.integer :tasks
      t.integer :monthly_cost
      t.integer :yearly_cost
      t.boolean :active, null:false, default: false

      t.timestamps
    end

    add_column :companies, :billing_plan_id, :integer
  end
end
