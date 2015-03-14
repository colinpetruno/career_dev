class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :company, null: false
      t.references :funding_instrument, null: false
      t.integer :amount_in_cents, null: false
      t.boolean :processed, null: false, default: false
    end
  end
end
