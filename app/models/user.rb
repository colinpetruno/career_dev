class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :offers
  has_many :tasks, through: :offers
  belongs_to :company

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



  def update_points
    update_column(:points, sum_points)
  end

  def create_or_associate_company
    Company.create_or_associate(self)
  end

  def domain
    email.split('@').last
  end

  private

  def sum_points
    approved_tasks.inject(0) { |sum, task| sum + task.points }
  end

  def approved_tasks
    tasks.merge(Offer.approved)
  end
end
