class ChangeInvitationTokens < ActiveRecord::Migration
  def change
    rename_column :invitation_tokens, :sent_by, :invitation_id
  end
end
