module Offerable
  extend ActiveSupport::Concern

  def approved_offers
    users.merge(Offer.approved)
  end

  def completed_offers
    users.merge(Offer.completed)
  end

  def unaccepted_offers
    users.merge(Offer.not_accepted)
  end

  def accepted_offers
    users.merge(Offer.accepted)
  end
end
