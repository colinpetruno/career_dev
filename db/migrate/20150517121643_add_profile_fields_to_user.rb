class AddProfileFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :resides, :string
    add_column :users, :start_date, :string
    add_column :users, :hometown, :string
    add_column :users, :interests, :string
  end
end
