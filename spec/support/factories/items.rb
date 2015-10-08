require "support/resources/item"

FactoryGirl.define do
  factory :item, class: Qiita::Team::Services::Resources::Item do
    body "# Example"
    coediting false
    comment_count 0
    created_at { Time.now }
    created_at_as_seconds { created_at.to_i }
    created_at_in_words "just now"
    editor { build(:user) }
    id { generate(:id) }
    lgtm_count 0
    message { FFaker::Lorem.sentence }
    rendered_body "<h1>Example</h1>"
    stock_count 0
    stock_users []
    tags { [build(:tagging)] }
    title "Example title"
    updated_at { Time.now }
    updated_at_in_words "just now"
    url { "#{build(:team).url}/#{id}" }
    user
    uuid { "4bd431809afb1bb99e4#{generate(:id)}" }
  end
end
