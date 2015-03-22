class AddPrerequisiteToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :prerequisite_id, :integer
  end
end
