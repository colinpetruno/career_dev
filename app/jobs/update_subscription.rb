class UpdateSubscription
  @queue = :payments

  def self.perform(subscription_id)
    subscription = Subscription.find(subscription_id)
    customer = Stripe::Customer.retrieve(subscription.company.stripe_id)
    balanced_object = customer.subscriptions.retrieve(subscription.stripe_id)
    balanced_object.plan = subscription.plan_name
    balanced_object.save
  end
end
