class Company < ActiveRecord::Base
  DEFAULT_CATEGORIES = %w(
    Engineering
    Marketing
    Product
    Sales
  )

  has_many :bank_accounts
  has_many :categories
  has_many :credit_cards
  has_many :invitations
  has_many :funding_instruments
  has_many :offers, through: :tasks
  has_many :tasks
  has_many :users
  has_one :subscription

  validates :name, uniqueness: true

  before_save :set_slug
  after_create :create_payment_customer
  before_create :create_default_categories

  def to_param
    slug
  end

  def stripe_customer
    @customer ||= Stripe::Customer.retrieve(stripe_id)
  end

  private

  def create_default_categories
    DEFAULT_CATEGORIES.each do |category|
      self.categories.build(name: category)
    end
  end

  def create_payment_customer
    customer = Stripe::Customer.create(
      description: self.name,
      plan: "#{subscription.frequency}_#{subscription.billing_plan_id}"
    )

    update_column(:stripe_id, customer.id)

    subscription.
      update_column(:stripe_id, customer.subscriptions.first.id)
  end

  def set_slug
    self.slug = name.parameterize
  end
end
