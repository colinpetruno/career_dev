class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :company
      t.references :user
      t.string :emails
    end
  end
end
