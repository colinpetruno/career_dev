class BillingPlan < ActiveRecord::Base
  has_many :companies

  scope :active, -> { where(active: true) }

  def users
    read_attribute(:users) == 0 ? "Unlimited" : read_attribute(:users)
  end

  def tasks
    read_attribute(:tasks) == 0 ? "Unlimited" : read_attribute(:tasks)
  end
end
