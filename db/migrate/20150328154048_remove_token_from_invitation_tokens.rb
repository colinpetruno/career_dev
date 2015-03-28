class RemoveTokenFromInvitationTokens < ActiveRecord::Migration
  def change
    remove_column :invitation_tokens, :token
  end
end
