class RegistrationsController < ApplicationController
  respond_to :html

  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(registration_params)
    if @registration.register
      sign_in(@registration.user)
    end

    respond_with @registration, location: tasks_path
  end

  private

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
