class CompaniesController < AuthenticatedController
  load_and_authorize_resource find_by: :slug
  layout "settings"

  def edit

  end

  def update
    @company.update(company_params)

    if @company.save
      redirect_to edit_company_path(@company)
    else
      render "edit"
    end
  end

  def company_params
    params.require(:company).permit(:name, :domain)
  end
end
