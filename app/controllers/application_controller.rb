class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_company

  def after_sign_in_path_for(resource)
    company_tasks_path(resource.company)
    #request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end

  def current_company
    current_user.present? ? current_user.company : nil
  end
end
