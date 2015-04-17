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

    create_email_record(task, user)
  end

  def task_accepted(task, user)

  end

  private

  def create_email_record(task, user)
    task.
      email_records.
      create(user_id: user.id,
             mailer_class: "TaskMailer",
             mailer_method: "task_notification",
            )
  end

  def routes
    Rails.application.routes.url_helpers
  end
end
