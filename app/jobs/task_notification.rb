class TaskNotification
  @queue = :emails

  def self.perform(task_id, user_id)
    task = Task.find(task_id)
    recipient = User.find(user_id)


    TaskMailer.task_notification(task, recipient).deliver
  end
end
