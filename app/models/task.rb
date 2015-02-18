class Task < ActiveRecord::Base

  # i left off needing to be able to approve an offer an admin
  # which should recalculate the points for the user
  DIFFICULTY = [1,2,3,4,5]
  CATEGORIES = %w(Marketing Product Development)

  has_many :offers
  has_many :users, through: :offers

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

  def points
    (((difficulty + size) * normalized_fun_factor) * 10).to_i
  end


  #might not need these
  def approved_offers
    users.merge(Offer.approved)
  end

  def unaccepted_offers
    users.merge(Offer.not_accepted)
  end

  def accepted_offers
    users.merge(Offer.accepted)
  end

  def completed_offers
    users.merge(Offer.completed)
  end

  def normalized_fun_factor
    old_range = (DIFFICULTY.last - DIFFICULTY.first).to_f
    new_range = 1.to_f
    (((inverse_fun_factor.to_f - DIFFICULTY.first.to_f) * new_range) / old_range) + 1
  end

  def inverse_fun_factor
    DIFFICULTY.reverse[fun_factor - 1]
  end

end
