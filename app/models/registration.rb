class Registration
  include ActiveModel::Model
  # include ActiveModel::Errors

  attr_accessor(
    :first_name,
    :last_name,
    :email,
    :company_name,
    :password,
    :password_confirmation,
    :user,
    :company,
    :plan_id,
    :frequency,
    :subscription
  )

  validates :company_name, presence: true
  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :plan_id, presence: true
  validates :frequency, presence: true

  def register
    if valid?
      create_and_save_user
    else
      false
    end
  end

  def create_and_save_user
    self.company = Company.new(
      name: company_name
    )

    self.subscription = Subscription.new(
      billing_plan_id: plan_id.to_i,
      frequency: frequency.downcase
    )

    self.user = User.new(
      email: email,
      password: password,
      password_confirmation: password_confirmation,
      first_name: first_name,
      last_name: last_name,
      role: "Company Admin"
    )

    self.company.users << self.user
    self.company.subscription = self.subscription

    if self.company.save
      true
    else
      collect_errors
      false
    end
  end

  def collect_errors
    self.company.errors.each do |key, value|
      self.errors.add(key, value)
    end

    self.user.errors.each do |key, value|
      self.errors.add(key, value)
    end
  end

end
