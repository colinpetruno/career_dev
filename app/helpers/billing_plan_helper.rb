module BillingPlanHelper
  def active_plan?(plan)
    return false unless current_user.present?
    plan == current_company.billing_plan
  end
end
