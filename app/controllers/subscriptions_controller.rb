class SubscriptionsController < AuthenticatedController
  def update
    subscription = Subscription.find(params[:id])
    subscription.update(subscription_params)
    subscription.save
    redirect_to company_billing_plan_path(current_company)
  end

  private

  def subscription_params
    params.require(:subscription).permit(:billing_plan_id)
  end
end
