class Invitation < ActiveRecord::Base
  belongs_to :company
  belongs_to :user
  has_many :invitation_tokens

  before_create :create_tokens

  validate :all_emails_valid

  private

  def all_emails_valid
    self.emails.split(",").each do |email|
      unless EmailValidator.valid?(email)
        errors.add(:emails, "Invalid Email Entered")
      end
    end
  end

  def create_tokens
    self.emails.split(",").each do |email|

    end
  end
end
