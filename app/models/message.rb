class Message < ActiveRecord::Base
  def self.with_users(sender:, recipient:)
    new(sender_id: sender.id, recipient_id: recipient.id)
  end

  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"
end
