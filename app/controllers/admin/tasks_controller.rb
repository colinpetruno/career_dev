class Admin::TasksController < ApplicationController
  def index
    @tasks = Task.
      all.
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
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
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
      permit(:category, :description, :difficulty, :fun_factor, :size, :title, :company_id, :user_id)
  end
end
