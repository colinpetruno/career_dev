class CreateVerification < ActiveRecord::Migration
  def change
    create_table :verifications do |t|
      t.references :bank_account
      t.string :status
      t.string :href
      t.integer :attempts_remaining

      t.timestamps
    end
  end
end
