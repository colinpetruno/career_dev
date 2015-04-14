class DeviseMailer < MandrillMailer::TemplateMailer
  default from: "support@treeha.us"

  def invitation_instructions(record, token, opts={})
    # record is a user object
    # token - "143KC-GnvdyjCipzD7WD"

    url = routes.accept_user_invitation_url(invitation_token: token)

    mandrill_mail(
      template: "invitation",
      to: record.email,
      subject: "#{record.invited_by.first_name} has invited you to the Treehaus",
      vars: {
        INVITER_NAME: inviter_name(record.invited_by),
        REDEMPTION_URL: url
      }
    )
  end

  private

  def routes
    Rails.application.routes.url_helpers
  end

  def inviter_name(user)
    "#{user.first_name} #{user.last_name}"
  end
end
