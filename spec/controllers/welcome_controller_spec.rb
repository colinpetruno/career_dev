require 'rails_helper'

RSpec.describe WelcomeController, :type => :controller do
  login_user
  before { StripeMock.start }

  describe "GET index" do
    it "redirects to tasks path if user is signed in" do
      # Purpose: Ensure users are already signed in are directed directly
      # into the application
      get :index
      expect(response).
        to redirect_to(company_tasks_path(@registration.company))
    end
  end
end
