# colin@pckg.es
# pKdc4_VTVEGr3WiEYiXBKw

ActionMailer::Base.smtp_settings = {
  :address   => "smtp.mandrillapp.com",
  :port      => 587,
  :user_name => ENV.fetch("MANDRILL_USER"),
  :password  => ENV.fetch("MANDRILL_API_KEY"),
  :domain    => 'heroku.com'
}
ActionMailer::Base.delivery_method = :smtp

MandrillMailer.configure do |config|
  config.api_key = ENV.fetch("MANDRILL_API_KEY")
end
