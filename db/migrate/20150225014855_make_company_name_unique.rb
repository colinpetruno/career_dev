class MakeCompanyNameUnique < ActiveRecord::Migration
  def change
    add_index :companies, :name, unique: true
    add_index :companies, :domain, unique: true
  end
end
