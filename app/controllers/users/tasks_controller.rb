class Users::TasksController < AuthenticatedController
  def index
    @tasks = current_user.tasks.decorate
  end
end
