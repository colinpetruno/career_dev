class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.references :user, null: false
      t.references :task, null: false

      t.timestamps null: false
    end
  end
end
