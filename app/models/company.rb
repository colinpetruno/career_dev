class Company < ActiveRecord::Base

  def self.create_or_associate(user)
    company = Company.where(domain: user.domain)
    if company.blank?
      user.build_company(domain: user.domain, name: user.domain)
    else
      user.company = company
    end
  end
end
