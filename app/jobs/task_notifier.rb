class TaskNotifier
  @queue = :emails

  def self.perform(task_id)
    task = Task.find(task_id)

    task.company.users.each do |user|
      Resque.enqueue(TaskNotification, task_id, user_id)
    end
  end
end
