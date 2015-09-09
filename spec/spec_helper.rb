require "qiita_team_services"

Dir.glob("spec/support/helpers/*.rb").each do |filepath|
  load filepath
end

require "support/factory_girl"

FactoryGirl.define do
  sequence(:id)
end
