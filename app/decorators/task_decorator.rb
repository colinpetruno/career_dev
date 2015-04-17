class TaskDecorator < Draper::Decorator
  delegate_all

  STEPS = {
    expressed_interest: "",
    accepted: "",
    completed: "",
    approved: ""
  }

  def task_link
    if can_complete_task?
      h.link_to(task.title, h.company_task_path(h.current_user.company, task))
    else
      task.title
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
    # TODO: figure out a better way, this is confusing because the button
    # is the button for that status not for that method
    if status
      h.render partial: "/tasks/offers/#{status}_button"
    else
      h.render partial: "offers/form", locals: { task: object }
    end
  end

  private

  def can_complete_task?
    h.current_user.present? && can_view_task?
  end

  def can_view_task?
    object.completable_for?(h.current_user) || h.can?(:manage, Task)
  end
end
