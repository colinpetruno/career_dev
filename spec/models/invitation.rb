require "rails_helper"

describe Invitation do
  it "should be invalid if an email is invalid" do
    invitation = build(:invitation, emails: "kjljlj, joijoi@example.com")

    expect(invitation.valid?).to eql(false)
  end

  it "should build invitation tokens on create" do
    invitation = create(:invitation)
    expect(invitation.invitation_tokens.length).to eql(2)
  end
end

