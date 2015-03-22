class Category < ActiveRecord::Base
  belongs_to :company
  has_many :tasks

  def tasks?
    self.tasks.present?
  end
end
