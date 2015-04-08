RSpec.configure do |config|
  config.before(:suite) do
    StripeMock.start

    begin
      DatabaseCleaner.start
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end
end

