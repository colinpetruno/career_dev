if ENV["REDISCLOUD_URL"]
  $redis = Redis.new(:url => ENV["REDISCLOUD_URL"])

  Resque.configure do |config|
    config.redis = $redis
  end
end
