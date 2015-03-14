class BillingPlansController < AuthenticatedController
  layout "settings"

  def show
    @plans = BillingPlan.active
  end

  def update
    billing_plan = BillingPlan.find(params[:billing_plan][:billing_plan_id])
    current_company.billing_plan = billing_plan

    if current_company.save
      redirect_to company_billing_plan_path(current_company)
    else

    end
  end

end
