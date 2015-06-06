class ThankYouDecorator < Draper::Decorator
  delegate_all

  decorates_association :sender
  decorates_association :recipient

  def message
    if object.private?
      "Some default message #TODO: Change me"
    else
      object.message
    end
  end
end
