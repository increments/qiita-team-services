require "support/resources/team_member"

FactoryGirl.define do
  factory :user, aliases: [:team_member], class: Qiita::Team::Services::Resources::TeamMember do
    team
    id { generate(:id) }
    name { "name#{id}" }
    url { "#{team.url}/#{name}" }
    profile_image_url "http://example.com"
  end
end
