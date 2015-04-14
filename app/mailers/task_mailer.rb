class TaskMailer < MandrillMailer::TemplateMailer
  default from: "support@treeha.us"

  def task_notification(task, user)
    task_url = routes.company_task_url(user.company, task)

    mandrill_mail(
      template: "new-task",
      to: user.email,
      subject: "A new task has been posted!",
      vars: {
        TASK_URL: task_url
      }
    )
  end

  private

  def routes
    Rails.application.routes.url_helpers
  end
end
