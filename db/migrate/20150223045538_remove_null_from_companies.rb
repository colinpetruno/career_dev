class RemoveNullFromCompanies < ActiveRecord::Migration
  def change
    change_column :companies, :domain, :string, null: true
  end
end
