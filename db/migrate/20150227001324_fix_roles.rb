class FixRoles < ActiveRecord::Migration
  def change
    remove_column :users, :roles_mask
    add_column :users, :role, :string, null: false, default: "Employee"
  end
end
