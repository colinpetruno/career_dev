class CreatePrequisites < ActiveRecord::Migration
  def up
    create_table :prerequisitables do |t|
      t.integer :task_id, null: false
      t.integer :prerequisite_id, null: false
    end
  end

  def down
    drop_table :prerequisitables
  end
end
