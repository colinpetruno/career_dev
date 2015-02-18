class Participant < ActiveRecord::Base
  belongs_to :participant, foreign_key: :user_id
  belongs_to :task
end
