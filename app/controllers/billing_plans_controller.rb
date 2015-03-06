class BillingPlansController < AuthenticatedController
  layout "settings"

  def index
    @plans = BillingPlan.active
  end

end
