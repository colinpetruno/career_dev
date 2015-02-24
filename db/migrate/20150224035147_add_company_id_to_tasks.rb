class AddCompanyIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :company_id, :integer, null: false
  end
end
