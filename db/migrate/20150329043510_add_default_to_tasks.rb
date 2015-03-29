class AddDefaultToTasks < ActiveRecord::Migration
  def change
    change_column :tasks, :fun_factor, :integer, default: 3
    change_column :tasks, :size, :integer, default: 3
    change_column :tasks, :difficulty, :integer, default: 3
  end
end
