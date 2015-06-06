class Admin::TasksController < ApplicationController
  load_and_authorize_resource

  def index
    @tasks = current_user.
      company.
      tasks.
      group_by { |tasks| tasks.category }
  end

  def new
    @task = Task.from(current_user)
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to admin_task_path(@task)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to admin_task_path(@task)
    else
      render :edit
    end
  end

  private

  def task_params
    params.
      require(:task).
      permit(:category, :description, :title, :company_id, :user_id)
  end
end
