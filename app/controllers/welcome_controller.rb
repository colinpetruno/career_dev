class WelcomeController < ApplicationController
  def index
    redirect_to(company_tasks_path(current_company)) if user_signed_in?
  end
end
