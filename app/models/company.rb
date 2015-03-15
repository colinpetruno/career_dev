class Company < ActiveRecord::Base
  belongs_to :billing_plan
  has_many :tasks
  has_many :users
  has_many :funding_instruments
  has_many :credit_cards
  has_many :bank_accounts
  has_many :payments

  validates :name, uniqueness: true
  validates :domain, uniqueness: true

  before_save :set_slug

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

  def balanced_customer
    @customer ||= Balanced::Customer.fetch(billing_url)
  end

  private

  def set_slug
    self.slug = name.parameterize
  end
end
