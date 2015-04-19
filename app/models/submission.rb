class Submission < ActiveRecord::Base
  has_one :task, through: :offer
  belongs_to :company
  belongs_to :offer
  belongs_to :user

  def approved?
    # TODO: Test me?
    self.offer.approved?
  end
end
