class AddFriendlyNameToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :slug, :string, null: false
  end
end
