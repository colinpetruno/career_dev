class AddUserIdandCompanyIdToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :user_id, :integer, null: false
    add_column :submissions, :company_id, :integer, null: false
  end
end
