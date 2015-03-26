class UserMailer < MandrillMailer::TemplateMailer
  default from: 'support@treeha.us'

  def welcome_email(user)
    # [{"email"=>"colinpetruno@gmail.com",
    # "status"=>"sent",
    # "_id"=>"3a01e1bd88bb4bfa9d41e83b9cb10f50",
    # "reject_reason"=>nil}]
    mandrill_mail(
      template: "base-template",
      to: user.email,
      subject: 'Welcome to My Awesome Site',
      vars: {}
    )
  end
end
