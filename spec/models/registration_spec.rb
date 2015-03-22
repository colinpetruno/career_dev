require "rails_helper"

describe Registration do
  before { StripeMock.start }

  context "validation" do
    it { should validate_presence_of(:company_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:password_confirmation) }
    it { should validate_presence_of(:plan_id) }
    it { should validate_presence_of(:frequency) }
  end

  describe "#register" do
    it "should create a company, subscription, and user" do
      registration = build(:registration)
      registration.register

      # test
      expect(registration.user).
        to be_instance_of(User)

      expect(registration.subscription).
        to be_instance_of(Subscription)

      expect(registration.company).
        to be_instance_of(Company)
    end
  end

end
