class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :recipient_id
      t.integer :sender_id
      t.string :type
      t.text :message
      t.boolean :private

      t.timestamps
    end
  end
end
