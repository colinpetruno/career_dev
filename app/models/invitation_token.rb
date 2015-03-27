class InvitationToken < ActiveRecord::Base
  belongs_to :invitation

  before_create :create_token

  private

  def create_token
    self.token = SecureRandom.urlsafe_base64
  end

end
