class Company < ActiveRecord::Base
  has_many :tasks

  validates :name, uniqueness: true
  validates :domain, uniqueness: true

  before_save :set_slug

  def self.create_or_associate(user)
    company = Company.where(domain: user.domain)
    if company.blank?
      user.build_company(domain: user.domain, name: user.domain)
    else
      user.company = company
    end
  end

  def to_param
    slug
  end

  private

  def set_slug
    self.slug = name.parameterize
  end
end
