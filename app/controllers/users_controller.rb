class UsersController < AuthenticatedController
  load_and_authorize_resource except: [:update]
  layout "settings"

  def index
  end

  def edit
  end

  def update
    company = Company.where(slug: params[:company_id]).first
    @user = company.users.find(params[:id])

    authorize! :manage, @user

    @user.update(user_params)
    if @user.save
      redirect_to company_users_path(current_user.company)
    else
      render "edit"
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :role)
  end
end
