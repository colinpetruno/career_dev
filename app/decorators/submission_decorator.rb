class SubmissionDecorator < Draper::Decorator
  delegate_all

  decorates_association :user

  def link
    # TODO: Test me
    if submission.offer.approved?
      h.link_to "View", h.submission_path(submission), class: "button"
    else
      h.link_to "Review", h.submission_path(submission), class: "button"
    end
  end

  def accept_form
    if !approved?
      h.render partial: "submissions/accept", locals: { submission: self }
    end
  end
end
