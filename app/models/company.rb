class Company < ActiveRecord::Base
  belongs_to :billing_plan
  has_many :tasks
  has_many :users
  has_many :funding_instruments
  has_many :credit_cards
  has_many :bank_accounts
  has_one :subscription

  validates :name, uniqueness: true
  # validates :domain, uniqueness: true

  before_save :set_slug
  after_create :create_payment_customer

  #def self.create_or_associate(user)
    #company = Company.where(domain: user.domain)
    #if company.blank?
      #user.build_company(domain: user.domain, name: user.domain)
    #else
      #user.company = company
    #end
  #end

  def to_param
    slug
  end

  def stripe_customer
    @customer ||= Stripe::Customer.retrieve(stripe_id)
  end

  private

  def create_payment_customer
    customer = Stripe::Customer.create(
      description: self.name,
      plan: "#{subscription.frequency}_#{subscription.billing_plan_id}"
    )
    update_column(:stripe_id, customer.id)
    subscription.update_column(:stripe_id, customer.subscription.id)
  end

  def set_slug
    self.slug = name.parameterize
  end
end
