class EmailRecord < ActiveRecord::Base
  belongs_to :emailable, polymorphic: true

end
