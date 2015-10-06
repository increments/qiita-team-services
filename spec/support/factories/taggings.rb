require "support/resources/tagging"

FactoryGirl.define do
  factory :tagging, class: Qiita::Team::Services::Resources::Tagging do
    name "Ruby"
    url_name "ruby"
    versions %w(1.9.3 2.0.0)
  end
end
