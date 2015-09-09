describe Qiita::Team::Services::Services::SlackV2 do
  include Qiita::Team::Services::Helpers::HttpClientStubHelper
  include Qiita::Team::Services::Helpers::ServiceHelper
  include Qiita::Team::Services::Helpers::SlackServiceHelper

  shared_context "Delivery success" do
    before do
      stubs = get_http_client_stub(service)
      stubs.post(webhook_url) do |_env|
        [200, { "Content-Type" => "application/json" }, { message_id: 1 }]
      end
    end
  end

  shared_context "Delivery fail" do
    before do
      stubs = get_http_client_stub(service)
      stubs.post(webhook_url) do |_env|
        [400, {}, ""]
      end
    end
  end

  let(:service) do
    described_class.new(properties)
  end

  let(:properties) do
    {
      "webhook_url" => webhook_url,
      "username" => username,
      "icon_emoji" => icon_emoji,
    }
  end

  let(:webhook_url) do
    "https://example.com"
  end

  let(:username) do
    "qiitan"
  end

  let(:icon_emoji) do
    ":qiitan:"
  end

  it_behaves_like "service"
  it_behaves_like "Slack services"
end
