class CategoriesController < AuthenticatedController
  layout "settings"

  def index
    @categories = current_company.categories.includes(:tasks)
  end

  def new
    @category = Category.new
  end

  def create
    @category = current_company.categories.build(category_params)

    if @category.save
      redirect_to company_categories_path(current_company)
    else
      render "edit"
    end
  end

  def edit
    @category = current_company.categories.find(params[:id])
  end

  def update
    @category = current_company.categories.find(params[:id])
    @category.update(category_params)

    if @category.save
      redirect_to company_categories_path(current_company)
    else
      render "edit"
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
