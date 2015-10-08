require "ffaker"
require "pry"
require "webmock/rspec"
require "faraday"
require "qiita_team_services"

Dir.glob("spec/support/{helpers,matchers}/*.rb").each do |filepath|
  load filepath
end

require "support/factory_girl"

FactoryGirl.define do
  sequence(:id)
end

Faraday.default_adapter = :test
