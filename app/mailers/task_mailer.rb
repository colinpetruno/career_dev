class TaskMailer < MandrillMailer::TemplateMailer
  default from: "support@treeha.us"

  def task_notification(task, user)
    task = Task.find(task_id)
    task_url = routes.company_task_url(user.company, task)

    mandrill_mail(
      template: "new_task",
      to: user.email,
      subject: "A new task has been posted!",
      vars: {
        TASK_LINK: task_url
      }
    )
  end
end
