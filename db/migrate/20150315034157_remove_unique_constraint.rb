class RemoveUniqueConstraint < ActiveRecord::Migration
  def up
    change_column :users, :company_id, :integer, null: true
  end
end
