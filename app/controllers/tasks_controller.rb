class TasksController < AuthenticatedController
  load_and_authorize_resource except: [:index, :show]
  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = current_company.
      tasks.
      with_category(params[:category] || nil).
      includes(:category).
      page(params[:page])

    @categories = current_company.categories.includes(:tasks)

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.for(current_user).find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
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

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to company_task_path(current_user.company, @task), notice: 'Task was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def task_params
    # "task"=>{"title"=>"Engineering task 4", "description"=>"Test Prerequisites", "difficulty"=>"3", "fun_factor"=>"3", "size"=>"3", "category_id"=>"86", "prerequisite_ids"=>["", "112"]},
    params.
      require(:task).
      permit(:category_id, :description, :difficulty, :fun_factor,
             :size, :title, :company_id, :user_id, :prerequisite_ids => []).
      merge(user_id: current_user.id, company_id: current_user.company_id)
  end

end
