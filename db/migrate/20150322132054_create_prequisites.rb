class CreatePrequisites < ActiveRecord::Migration
  def change
    create_table :prequisitable do |t|
      t.integer :task_id, null: false
      t.integer :prerequisite_id, null: false
    end

    remove_column :tasks, :prerequisite_id
  end
end
