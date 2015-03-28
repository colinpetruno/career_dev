class InvitationEmail
  @queue = :emails

  def self.perform(invitation_token_id)
    invitation_token = InvitationToken.find(invitation_token_id)
    company = invitation_token.invitation.company

    new_user = company.users.build(email: invitation_token.email)

    User.invite!({
        email: new_user.email,
        company_id: new_user.company_id
      },
      invitation_token.invitation.user
    )
  end
end
