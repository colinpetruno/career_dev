class AddClosedToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :closed, :boolean, default: false, null: false
  end
end
