class InvitationsController < AuthenticatedController
  layout "settings"

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = current_company.invitations.build(invitation_params)
    @invitation.user_id = current_user.id

    if @invitation.save
      redirect_to company_users_path(current_company)
    else
      render "new"
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:emails)
  end
end
