RSpec::Matchers.define :match_slack_text_request do
  match do |request_body|
    request_body.is_a?(Hash) && \
      request_body.key?(:text) && \
      !request_body.key?(:attachments) && \
      request_body[:text].is_a?(String) && \
      !illegal_slack_link_format?(request_body[:text])
  end

  def illegal_slack_link_format?(text)
    text.match(/<[^>]+</)
  end
end
