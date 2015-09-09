RSpec::Matchers.define :match_slack_attachments_request do
  match do |request_body|
    request_body.is_a?(Hash) \
    && request_body.key?(:attachments) \
    && request_body[:attachments].is_a?(Array)
  end
end
