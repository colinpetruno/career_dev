require 'rails_helper'

RSpec.describe WelcomeController, :type => :controller do
  describe "GET index" do
    login_user

    it "redirects to tasks path if user is signed in" do
      get :index
      expect(response).to redirect_to(tasks_path)
    end
  end
end
