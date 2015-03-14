class Verification < ActiveRecord::Base
  belongs_to :bank_account
  before_create :set_verification_info

  SUCCEEDED = "succeeded"

  attr_accessor :amount_one, :amount_two

  def verify
    return self if self.status == SUCCEEDED
    verification = details
    verification.confirm(amount_one, amount_two)
    set_verification_info
    save
  end

  private

  def set_verification_info
    self.href = details.href
    self.status = details.verification_status
    self.attempts_remaining = details.attempts_remaining
    self
  end

  def details
    @verification ||= fetch_verification
  end

  def fetch_verification
    if href.present?
      Balanced::BankAccountVerification.fetch(href)
    else
      bank_account.balanced_object.verify
    end
  end
end
