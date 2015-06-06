class Task < ActiveRecord::Base
  paginates_per 15

  belongs_to :category
  belongs_to :company
  belongs_to :user

  has_many :email_records, as: :emailable
  has_many :offers
  has_many :users, through: :offers

  has_many :prerequisitables
  has_many :prerequisites, through: :prerequisitables

  has_many :postrequisites,
    class_name: "Prerequisitable",
    foreign_key: "prerequisite_id"
  has_many :postrequistables, through: :postrequisites, source: :task

  has_many :submissions, through: :offers do
    def not_approved
      # TODO: Test me
      where("offers.approved = ?", false) # .decorate
    end

    def approved
      where("offers.approved = ?", true) # .decorate
    end
  end

  after_create :create_notification_emails

  scope :with_category, proc { |category_id|
    if (category_id.present?)
      where(category_id: category_id)
    end
  }

  def self.for(user)
    where(company_id: user.company_id).
      includes(:prerequisites).
      includes(:prerequisitables)
  end

  def self.from(user)
    new(user_id: user.id, company_id: user.company_id)
  end

  def has_expressed_interest?(user)
    offers.map(&:user_id).include?(user.id)
  end

  def accepted?(user)
    offers.accepted.map(&:user_id).include?(user.id)
  end

  def approved?(user)
    offers.approved.map(&:user_id).include?(user.id)
  end

  def completed?(user)
    offers.completed.map(&:user_id).include?(user.id)
  end

  def offer_for(user)
    offers.where(user_id: user.id).first
  end

  def completable_for?(user)
    # TODO: TEST ME
    self.prerequisites.blank? || completed_prerequisites?(user)
  end

  private

  def completed_prerequisites?(user)
    (prerequisites.map(&:id) - user.offers.approved.pluck(:task_id)).empty?
  end

  def create_notification_emails
    Resque.enqueue(TaskNotifier, self.id)
  end
end
