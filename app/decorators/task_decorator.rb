class TaskDecorator < Draper::Decorator
  delegate_all

  decorates_association :user
  decorates_association :offers

  def task_link
    if can_complete_task?
      h.link_to(title_with_name, h.company_task_path(h.current_user.company, task))
    else
      h.content_tag(:strong, list_title)
    end
  end

  def title_with_name
    if task.user == h.current_user
      "#{user.display_name} need help with #{task.title}"
    else
      "#{user.display_name} needs help with #{task.title}"
    end
  end

  def status
    case
    when object.approved?(h.current_user)
      "approved"
    when object.completed?(h.current_user)
      "completed"
    when object.accepted?(h.current_user)
      "accepted"
    when object.has_expressed_interest?(h.current_user)
      "expressed_interest"
    else
      nil
    end
  end

  def next_step_button
    if status
      h.render partial: "/tasks/offers/button_for_#{status}_tasks"
    else
      h.render partial: "offers/form", locals: { task: object }
    end
  end

  def completed_submissions
    object.offers.approved.map{ |o| o.submission }
  end

  def user_photo
    user.photo
  end

  private

  def can_complete_task?
    h.current_user.present? && can_view_task?
  end

  def can_view_task?
    object.completable_for?(h.current_user) || h.can?(:manage, Task)
  end
end
