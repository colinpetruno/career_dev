class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.integer :difficulty, null: false
      t.integer :fun_factor, null: false
      t.integer :size, null: false
      t.string :category, null: false

      t.timestamps
    end
  end
end
