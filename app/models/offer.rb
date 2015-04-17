class Offer < ActiveRecord::Base
  belongs_to :user
  belongs_to :task

  has_one :submission

  scope :accepted, -> { where(accepted: true).where(approved: false) }
  scope :approved, -> { where(approved: true) }
  scope :completed, -> { where(completed: true) }
  scope :not_accepted, -> { where(accepted: false) }

  after_save :update_user_points

  def for_user(user)
    self.user_id = user.id
    self
  end

  private

  def update_user_points
    return unless accepted?
    user.update_points
  end
end
