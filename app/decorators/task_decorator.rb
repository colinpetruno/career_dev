class TaskDecorator < Draper::Decorator
  delegate_all

  def task_link
    if can_complete_task?
      h.link_to(task.title, h.company_task_path(h.current_user.company, task))
    else
      task.title
    end
  end

  def interest
    if object.has_expressed_interest?(h.current_user)
      h.render partial: "tasks/offers/expressed_interest"
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
