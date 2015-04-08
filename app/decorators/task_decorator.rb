class TaskDecorator < Draper::Decorator
  delegate_all

  def task_link
    if h.current_user.present? && object.completable_for?(h.current_user)
      h.link_to(task.title, h.company_task_path(h.current_user.company, task))
    else
      task.title
    end
  end
end
