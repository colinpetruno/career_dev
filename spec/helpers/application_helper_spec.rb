require "rails_helper"
include Devise::TestHelpers

describe ApplicationHelper do
  before { StripeMock.start }

  describe "#current_user" do
    it "returns a decorated user" do
      user = FactoryGirl.create(:user)
      sign_in(user)

      expect(helper.current_user).to be_a(UserDecorator)
    end
  end
end
