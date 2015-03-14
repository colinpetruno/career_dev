class ScheduledPayment < ActiveRecord::Base
  before_save :calculate_amount
  belongs_to :company

  def self.from(company, old_billing_plan_id, new_billing_plan_id)
    scheduled_payment = new(company_id: company.id, old_billing_plan_id: old_billing_plan_id, new_billing_plan_id: new_billing_plan_id)
    scheduled_payment.save!
    scheduled_payment
  end

  private

  def calculate_amount
    self.amount = old_plan.monthly_cost - new_plan.monthly_cost
  end

  def old_plan
    BillingPlan.find(old_billing_plan_id)
  end

  def new_plan
    BillingPlan.find(new_billing_plan_id)
  end
end
