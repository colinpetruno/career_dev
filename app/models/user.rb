class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :offers
  has_many :tasks, through: :offers
  belongs_to :company


  # declare the valid roles -- do not change the order if you add more
  # roles later, always append them at the end!
  ROLES = ["Admin", "Company Admin", "Manager", "Employee"]

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
      user = User.new( name: data["name"],
                       email: data["email"],
                       password: Devise.friendly_token[0,20]
                     )
      user.create_or_associate_company
      user.save
    end
    user
  end

  def self.public_roles
    ROLES - ["Admin"]
  end

  def update_points
    update_column(:points, sum_points)
  end

  def is?(type)
    ROLES.include?(type.to_s.titleize) && role.eql?(type.to_s.titleize)
  end

  def role=(new_role)
    # overriding to prevent people from setting a user as an
    # admin through hackery or mass assignment
    if new_role != "Admin"
      write_attribute(:role, new_role)
    end
  end

  private

  def sum_points
    approved_tasks.inject(0) { |sum, task| sum + task.points }
  end

  def approved_tasks
    tasks.merge(Offer.approved)
  end
end
