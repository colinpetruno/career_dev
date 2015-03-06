module BillingPlanHelper
  def active_plan?(plan)
    return false unless current_user.present?
    plan.id == Subscription.active_for(current_user.company).try(:billing_plan_id)
  end
end
