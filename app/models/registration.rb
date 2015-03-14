class Registration
  include ActiveModel::Model

  attr_accessor(
    :first_name,
    :last_name,
    :email,
    :company_name,
    :password,
    :password_confirmation,
    :user
  )


  validates :company_name, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  def register
    if valid?
      create_and_save_user
    else
      false
    end
  end

  def create_and_save_user
    self.user = User.new(
      email: email,
      password: password,
      password_confirmation: password_confirmation,
      first_name: first_name,
      last_name: last_name
    )
    self.user.role = "Company Admin"
    self.user.build_company(name: company_name)

    self.user.save
  end

end
