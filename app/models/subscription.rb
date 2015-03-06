class Subscription < ActiveRecord::Base
  belongs_to :company
  belongs_to :billing_plan

  def self.active_for(company)
    where({company_id: company.id, active: true}).first
  end

  def self.billing_plan_for(company)
    where({company_id: company.id, active: true}).first.billing_plan
  end

end
