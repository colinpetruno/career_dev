class BillingPlan < ActiveRecord::Base
  FREQUENCIES = ["Monthly", "Yearly"]

  has_many :companies

  after_create :create_stripe_plans

  scope :active, -> { where(active: true) }

  def users
    read_attribute(:users) == 0 ? "Unlimited" : read_attribute(:users)
  end

  def tasks
    read_attribute(:tasks) == 0 ? "Unlimited" : read_attribute(:tasks)
  end

  def monthly
    Stripe::Plan.retrieve("monthly_#{self.id}")
  end

  def yearly
    Stripe::Plan.retrieve("yearly_#{self.id}")
  end

  def monthly_cost_in_dollars
    self.monthly_cost / 100
  end

  private

  def create_stripe_plans
    create_monthly_plan
    create_yearly_plan
  end

  def create_monthly_plan
    Stripe::Plan.create(
      amount: self.monthly_cost,
      interval: "month",
      trial_period_days: 30,
      name: "#{self.name} - Monthly",
      currency: "usd",
      id: "monthly_#{self.id}"
    )
  end

  def create_yearly_plan
    Stripe::Plan.create(
      amount: self.yearly_cost,
      interval: "year",
      trial_period_days: 30,
      name: "#{self.name} - Yearly",
      currency: "usd",
      id: "yearly_#{self.id}"
    )
  end
end
