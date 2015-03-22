module ControllerMacros
  def login_admin
    #before(:each) do
      #@request.env["devise.mapping"] = Devise.mappings[:admin]
      #sign_in FactoryGirl.create(:admin) # Using factory girl as an example
    #end
  end

  def login_user
    before(:each) do
      @registration = create(:registration)
      @registration.register
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = @registration.user
      sign_in user
    end
  end
end
