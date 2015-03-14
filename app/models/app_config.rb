require_dependency './lib/app_config_loader'
class AppConfig
  include Singleton

  class << self
    delegate :full_config, :s3_options, :group_names_mapping, :inverted_group_names_mapping, to: :instance
  end

  def self.[](key)
    instance[key]
  end

  def self.reset
    instance.reset
  end

  def [](key)
    initialize unless initialized?
    @app_config[key]
  end

  @initialized = false

  def initialized?
    @initialized
  end

  def initialize
    @full_config = AppConfigLoader.full_config.freeze
    @app_config = AppConfigLoader.load_config_for_env(Rails.env).freeze
    @initialized = true
  end

  def full_config(env)
    AppConfigLoader.load_config_for_env(env)
  end

  def reset
    @initialized = false
  end
end

