class TaskFinder
  # TODO: Test me
  def initialize(user:, category: nil, page: nil)
    @user = user
    @category = category
    @page = page
  end

  def get_tasks
    tasks.where.not(id: user_task_ids).page(page).decorate
  end

  private

  attr_reader :user, :category, :page

  def company
    user.company
  end

  def tasks
    company.tasks.with_category(category).includes(:category)
  end

  def by_page
    page(page)
  end

  def user_task_ids
    user.tasks.pluck(:id)
  end

end
