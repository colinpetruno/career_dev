class FundingInstrument < ActiveRecord::Base
  belongs_to :company

  # TODO: Test to make sure only 1 primary can be set
  scope :primary, -> { where(primary: true).first }

  def balanced_object
    details
  end
end
