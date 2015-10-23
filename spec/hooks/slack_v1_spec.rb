describe Qiita::Team::Services::Hooks::SlackV1 do
  include Qiita::Team::Services::Helpers::HttpClientStubHelper
  include Qiita::Team::Services::Helpers::HookHelper
  include Qiita::Team::Services::Helpers::SlackHookHelper

  shared_context "Delivery success" do
    before do
      stubs = get_http_client_stub(hook)
      stubs.post("/services/hooks/incoming-webhook?token=#{integration_token}") do |_env|
        [200, { "Content-Type" => "application/json" }, { message_id: 1 }]
      end
    end
  end

  shared_context "Delivery fail" do
    before do
      stubs = get_http_client_stub(hook)
      stubs.post("/services/hooks/incoming-webhook?token=#{integration_token}") do |_env|
        [400, {}, ""]
      end
    end
  end

  subject(:hook) do
    described_class.new(properties)
  end

  let(:properties) do
    {
      "teamname" => teamname,
      "integration_token" => integration_token,
      "username" => username,
      "icon_emoji" => icon_emoji,
    }
  end

  let(:teamname) do
    "increments"
  end

  let(:integration_token) do
    "integrationtoken"
  end

  let(:username) do
    "qiitan"
  end

  let(:icon_emoji) do
    ":qiitan:"
  end

  it_behaves_like "hook"
  it_behaves_like "Slack hook", hook: :hook
end
