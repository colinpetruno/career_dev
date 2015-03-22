class RemoveNullConstraintFromSubscriptions < ActiveRecord::Migration
  def change
    change_column :subscriptions, :stripe_id, :string, null: true
  end
end
