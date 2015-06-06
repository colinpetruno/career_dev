class ThankYousController < AuthenticatedController
  def new
    @user = current_company.users.find(params[:user_id]).decorate
    @thank_you = ThankYou.new
  end

  def create
    @user = current_company.users.find(params[:user_id])

    if ThankYou.create(thank_you_params)
      redirect_to company_user_path(current_company, @user)
    else
      render :new
    end
  end

  private

  def thank_you_params
    params.
      require(:thank_you).
      permit(:message, :private).
      merge(sender_id: current_user.id, recipient_id: @user.id)
  end
end
