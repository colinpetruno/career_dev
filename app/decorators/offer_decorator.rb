class OfferDecorator < Draper::Decorator
  delegate_all

  decorates_association :user

  def user_photo
    user.photo
  end

  def content
    if approved?
      h.render partial: "offers/approved", locals: { offer: self }
    elsif completed?
      h.render partial: "offers/completed", locals: { offer: self }
    elsif accepted?
      h.render partial: "offers/accepted", locals: { offer: self }
    else
      if h.current_user.can_accept?(offer)
        h.render partial: "offers/accept", locals: { offer: self }
      else
        "#{user.full_name} Offered to Help on #{h.l(offer.created_at, format: :short)}"
      end
    end
  end
end
