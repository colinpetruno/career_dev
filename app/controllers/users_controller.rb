class UsersController < AuthenticatedController
  load_and_authorize_resource
  layout "settings"

  def index
  end
end
