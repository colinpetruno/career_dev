class CreateEmailRecord < ActiveRecord::Migration
  def change
    create_table :email_records do |t|
      t.references :user, null:false
      t.integer :emailable_id
      t.string :emailable_type
      t.string :mailer_class, null: false
      t.string :mailer_method, null: false
      t.timestamps null: false
    end

    add_index :email_records, :emailable_id
  end
end
