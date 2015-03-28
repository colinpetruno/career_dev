class InvitationToken < ActiveRecord::Base
  belongs_to :invitation

  after_create :queue_invitation

  private

  def queue_invitation
    Resque.enqueue(InvitationEmail, self.id)
  end
end
