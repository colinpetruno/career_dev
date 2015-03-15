class RegistrationsController < ApplicationController
  respond_to :html
  before_filter :check_for_current_user

  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(registration_params)
    if @registration.register
      sign_in(@registration.user)
    end

    respond_with @registration, location: company_tasks_path(current_company)
  end

  private

  def check_for_current_user
    redirect_to tasks_path if current_user.present?
  end

  def registration_params
    params.
      require(:registration).
      permit(
        :company_name,
        :first_name,
        :last_name,
        :email,
        :password,
        :password_confirmation
      )
  end
end
