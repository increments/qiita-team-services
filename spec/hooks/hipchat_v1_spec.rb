describe Qiita::Team::Services::Hooks::HipchatV1 do
  include Qiita::Team::Services::Helpers::EventHelper
  include Qiita::Team::Services::Helpers::HookHelper

  EXPECTED_AVAILABLE_EVENT_NAMES = [
    :comment_created,
    :item_became_coediting,
    :item_created,
    :item_updated,
    :project_activated,
    :project_archived,
    :project_created,
    :project_updated,
    :team_member_added,
  ]

  shared_context "Delivery success" do
    before do
      allow_any_instance_of(HipChat::Room).to receive(:send).and_return(true)
    end
  end

  shared_context "Delivery fail" do
    before do
      allow_any_instance_of(HipChat::Room).to receive(:send).and_raise(HipChat::UnknownRoom)
    end
  end

  let(:hook) do
    described_class.new(properties)
  end

  let(:properties) do
    {
      "color" => color,
      "from" => from,
      "room" => room,
      "token" => token,
      "with_notification" => with_notification,
    }
  end

  let(:color) do
    "yellow"
  end

  let(:from) do
    "Qiita:Team"
  end

  let(:room) do
    "development"
  end

  let(:token) do
    "secrethipchattoken"
  end

  let(:with_notification) do
    false
  end

  it_behaves_like "hook"

  describe ".service_name" do
    subject do
      described_class.service_name
    end

    it { should eq "HipChat" }
  end

  describe ".available_event_names" do
    subject do
      described_class.available_event_names
    end

    it { should match_array EXPECTED_AVAILABLE_EVENT_NAMES }
  end

  describe "#ping" do
    subject do
      hook.ping
    end

    it "sends a text message" do
      expect_any_instance_of(HipChat::Room).to receive(:send).with(
        from,
        a_kind_of(String),
        color: color,
        notify: with_notification,
      ).once
      subject
    end

    context "when message is delivered successful" do
      include_context "Delivery success"

      it { expect { subject }.not_to raise_error }
    end

    context "when message is not delivered" do
      include_context "Delivery fail"

      it { expect { subject }.not_to raise_error }
    end
  end

  EXPECTED_AVAILABLE_EVENT_NAMES.each do |event_name|
    describe "##{event_name}" do
      subject do
        hook.public_send(event_name, public_send("#{event_name}_event"))
      end

      it "sends a text message with HipChat client" do
        expect_any_instance_of(HipChat::Room).to receive(:send).with(
          from,
          a_kind_of(String),
          color: color,
          notify: with_notification,
        ).once
        subject
      end

      context "when message is delivered successfully" do
        include_context "Delivery success"

        it { expect { subject }.not_to raise_error }
      end

      context "when message is not delivered successfully" do
        include_context "Delivery fail"

        it { expect { subject }.to raise_error(Qiita::Team::Services::DeliveryError) }
      end
    end
  end
end
