require 'active_support/core_ext/hash'

class AppConfigLoader
  def self.load_config_for_env(env)
    env = env.to_sym

    full_config = YAML.load_file('config/app_config.yml')
    secret_config = File.exists?('config/app_secrets.yml') ? YAML.load_file('config/app_secrets.yml') : {}

    full_config[:default].deep_merge(full_config[env] || {}).deep_merge(secret_config)
  end

  def self.full_config
    YAML.load_file('config/app_config.yml')
  end
end

