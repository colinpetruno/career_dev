class RemoveTaskPointsSystem < ActiveRecord::Migration
  def change
    remove_column :tasks, :difficulty
    remove_column :tasks, :fun_factor
    remove_column :tasks, :size
  end
end
