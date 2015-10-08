require "support/resources/project"

FactoryGirl.define do
  factory :project, class: Qiita::Team::Services::Resources::Project do
    user { build(:user) }
    editor { user }
    id { generate(:id) }
    name "Example name"
    body "# Example"
    rendered_body "<h1>Example</h1>"
    message { FFaker::Lorem.sentence }
    url { "#{build(:team).url}/projects/#{id}" }
    archived false
    created_at { Time.now }
    updated_at { Time.now }
  end
end
