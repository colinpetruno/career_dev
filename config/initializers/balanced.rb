puts "Configuring Balanced with token #{AppConfig[:balanced][:api_key]}"
Balanced.configure(AppConfig[:balanced][:api_key])
