class CreateInvitationTokens < ActiveRecord::Migration
  def change
    create_table :invitation_tokens do |t|
      t.string :email, null: false
      t.string :token, null: false, unique: true
      t.integer :sent_by
      t.datetime :accepted

      t.timestamps
    end
  end
end
