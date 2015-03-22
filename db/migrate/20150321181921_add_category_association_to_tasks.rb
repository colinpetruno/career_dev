class AddCategoryAssociationToTasks < ActiveRecord::Migration
  def up
    remove_column :tasks, :category
    add_column :tasks, :category_id, :integer, null: false
  end

  def down
    remove_column :tasks, :category_id
    add_column :tasks, :category, :string, null: false
  end

end
