class Subscription < ActiveRecord::Base
  belongs_to :company
  belongs_to :billing_plan

  before_save :queue_update_plan, if: :billing_plan_id_changed?

  def plan_name
    "#{self.frequency}_#{self.billing_plan_id}"
  end

  private

  def queue_update_plan
    Resque.enqueue(UpdateSubscription, self.id)
  end
end
