require "support/resources/team"

FactoryGirl.define do
  factory :team, class: Qiita::Team::Services::Resources::Team do
    id { generate(:id) }
    name { "name#{id}" }
    url { "https://#{name}.qiita.com" }
  end
end
