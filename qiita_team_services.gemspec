lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

module ::Qiita
  module Team
    module Services
    end
  end
end

require "qiita/team/services/version"

Gem::Specification.new do |spec|
  spec.name          = "qiita_team_services"
  spec.version       = Qiita::Team::Services::VERSION
  spec.authors       = ["Yuku Takahashi"]
  spec.email         = ["yuku@qiita.com"]
  spec.summary       = "Official Qiita:Team Services Integration"
  spec.homepage      = "https://github.com/increments/qiita-team-services"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = ["lib"]

  spec.add_dependency "activemodel-url_validator"
  spec.add_dependency "faraday", "~> 0.9"
  spec.add_dependency "faraday_middleware", "~> 0.10"
  spec.add_dependency "rails", "~> 4.2"
  spec.add_dependency "rails-i18n"

  # Service dependencies
  spec.add_dependency "hipchat", "~> 1.5.2"
  spec.add_dependency "slacken", "~> 0.1.3"

  spec.add_development_dependency "factory_girl", "~> 4.5.0"
  spec.add_development_dependency "ffaker", "~> 2.1"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake", "~> 10.4"
  spec.add_development_dependency "rspec", "~> 3.3"
  spec.add_development_dependency "rubocop", "~> 0.33"
  spec.add_development_dependency "webmock", "~> 1.21"
  spec.add_development_dependency "yard", "~> 0.8.7"
end
