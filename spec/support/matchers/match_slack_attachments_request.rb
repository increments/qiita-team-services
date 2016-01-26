RSpec::Matchers.define :match_slack_attachments_request do
  match do |request_body|
    request_body.is_a?(Hash) && \
      request_body.key?(:attachments) && \
      request_body[:attachments].is_a?(Array) && \
      request_body[:attachments].all?(&method(:text_valid_length?))
  end

  def text_valid_length?(attachment)
    attachment[:text].nil? || \
      attachment[:text].bytesize <= Qiita::Team::Services::Hooks::Concerns::Slack::TEXT_BYTESIZE_MAX
  end
end
