class UsersController < AuthenticatedController

  def index
    @users = current_company.users.decorate
  end

  def edit
    user = current_company.users.find(params[:id])
    @user = UserFormDecorator.decorate(user)

    authorize! :manage, @user
  end

  def show
    @user = current_company.users.find(params[:id]).decorate
  end

  def update
    company = Company.where(slug: params[:company_id]).first
    @user = company.users.find(params[:id])

    authorize! :manage, @user

    @user.update(user_params)
    if @user.save
      redirect_to company_user_path(current_company, @user)
    else
      render "edit"
    end
  end

  def user_params
    params.
      require(:user).
      permit(:first_name, :last_name, :email, :role, :avatar, :interests,
            :resides, :hometown)
  end
end
