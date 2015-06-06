class UserDecorator < Draper::Decorator
  delegate_all

  decorates_association :thank_yous

  def photo
    if avatar?
      h.cl_image_tag(avatar.path)
    else
      h.image_tag("placeholders/profile.gif")
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def display_name
    if user == h.current_user
      "You"
    else
      full_name
    end
  end

  def recent_thank_yous
    object.thank_yous.decorate.last(6)
  end
end
