describe Qiita::Team::Services::Hooks::SlackV2 do
  include Qiita::Team::Services::Helpers::HttpClientStubHelper
  include Qiita::Team::Services::Helpers::HookHelper
  include Qiita::Team::Services::Helpers::SlackHookHelper

  shared_context "Delivery success" do
    before do
      stubs = get_http_client_stub(hook)
      stubs.post(webhook_url) do |_env|
        [200, { "Content-Type" => "application/json" }, { message_id: 1 }]
      end
    end
  end

  shared_context "Delivery fail" do
    before do
      stubs = get_http_client_stub(hook)
      stubs.post(webhook_url) do |_env|
        [400, {}, ""]
      end
    end
  end

  subject(:hook) do
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

  it_behaves_like "hook"
  it_behaves_like "Slack hook", hook: :hook

  describe "#valid?" do
    subject { hook.valid? }

    context "when url starts with https://hooks.slack.com/" do
      let(:webhook_url) do
        "https://hooks.slack.com/services/foo/bar"
      end

      it { should be true }
    end

    context "when url does not start with https://hooks.slack.com/" do
      let(:webhook_url) do
        "http://hooks.slack.com/services/foo/bar"
      end

      it { should be false }
    end
  end
end
