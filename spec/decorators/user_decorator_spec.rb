require "rails_helper"

describe UserDecorator do
  before { StripeMock.start }
  let(:user) { FactoryGirl.create(:user).decorate }

  describe "#photo" do
    it "should return the sample photo if no avatar image" do
      expect(user.photo).to include("placeholders/profile.gif")
    end

    it "should return the image if avatar is present" do
      user_with_photo = FactoryGirl.create(:user, :with_avatar).decorate

      expect(user_with_photo.photo).
        to include(user_with_photo.avatar.public_id)
    end
  end

  describe "#full_name" do
    it "should combine first and last name" do
      expect(user.full_name).to eql("#{user.first_name} #{user.last_name}")
    end
  end
end
