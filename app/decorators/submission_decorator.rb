class SubmissionDecorator < Draper::Decorator
  delegate_all

  def link
    # TODO: Test me
    if submission.offer.approved?
      h.link_to "View", h.submission_path(submission), class: "button"
    else
      h.link_to "Review", h.submission_path(submission), class: "button"
    end
  end
end
