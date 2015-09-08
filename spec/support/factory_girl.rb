require "factory_girl"

Dir.glob("spec/support/factories/*.rb")
  .map { |filepath| filepath.split("/").last.split(".").first }
  .each { |name| require "support/factories/#{name}" }

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.lint
  end
end
