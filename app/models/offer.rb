class Offer < ActiveRecord::Base
  belongs_to :user
  belongs_to :task

  has_one :submission

  scope :accepted, -> { where(accepted: true).
                        where(approved: false).
                        where(completed: false)
                      }
  scope :approved, -> { where(approved: true) }
  scope :completed, -> { where(completed: true) }
  scope :not_accepted, -> { where(accepted: false) }

  after_save :update_user_points

  def self.for(task:, user:)
    new(task: task, user: user )
  end

  def accepted?
    self.accepted && !self.approved && !self.completed
  end

  def approved?
    self.approved && self.accepted && self.completed
  end

  def completed?
    self.completed && self.accepted && !self.approved
  end

  def for_user(user)
    self.user_id = user.id
    self
  end

  def complete_with_submission(submission_params)
    # TODO: Test me
    self.completed = true
    self.build_submission(submission_params)
  end

  private

  def update_user_points
    return unless accepted?
    user.update_points
  end
end
