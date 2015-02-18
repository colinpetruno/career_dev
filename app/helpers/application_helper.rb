module ApplicationHelper
  def sign_in_or_out_link
    if user_signed_in?
      link_to('Logout', destroy_user_session_path, :method => :delete)
    else
      link_to "Login", user_omniauth_authorize_path(:google_oauth2)
    end
  end
end
