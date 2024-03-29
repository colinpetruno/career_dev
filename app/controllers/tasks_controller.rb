class TasksController < AuthenticatedController
  load_and_authorize_resource except: [:index, :show]

  def index
    @tasks = TaskFinder.new(
      user: current_user,
      category: params[:category],
      page: params[:page]
    ).get_tasks


    @categories = current_company.categories

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @tasks }
    end
  end

  def show
    @task = current_company.tasks.find(params[:id]).decorate
    @offer = Offer.for(task: @task, user: current_user)

    if can?(:manage, Task) || @task.completable_for?(current_user)
      respond_to do |format|
        format.html
        format.json { render json: @task }
      end
    else
      raise CanCan::AccessDenied.new("Not authorized!", :read, Task)
    end
  end

  def new
    @tasks = current_company.
      tasks.
      with_category(params[:category] || nil).
      includes(:category).
      page(params[:page])

    @task = Task.from(current_user)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to company_task_path(current_user.company, @task),
        notice: 'Task was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(task_params)
        format.html do
          redirect_to @task, notice: "Task was successfully updated."
        end
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def task_params
    # "task"=>{"title"=>"Engineering task 4",
    # "description"=>"Test Prerequisites",
    # "category_id"=>"86", "prerequisite_ids"=>["", "112"]},
    params.
      require(:task).
      permit(:category_id, :description, :title, :company_id,
             :user_id, :prerequisite_ids => []).
      merge(user_id: current_user.id, company_id: current_user.company_id)
  end

end
