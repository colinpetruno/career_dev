class CreateCompany < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.string :domain, null: false
      t.timestamps null: false
    end
  end
end
