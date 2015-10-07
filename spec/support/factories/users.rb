require "support/resources/user"

FactoryGirl.define do
  factory :user, aliases: [:team_member], class: Qiita::Team::Services::Resources::User do
    team
    id { generate(:id) }
    url_name { "url_name#{id}" }
    name { "name#{id}" }
    url { "#{team.url}/#{name}" }
    profile_image_url "http://example.com"
  end
end
