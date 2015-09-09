require "active_support/concern"

require "support/helpers/event_helper"

module Qiita::Team::Services
  module Helpers
    module SlackServiceHelper
      extend ActiveSupport::Concern
      include EventHelper

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
      ].freeze

      included do
        shared_examples "Slack services" do
          describe ".service_name" do
            subject do
              described_class.service_name
            end

            it { should eq "Slack" }
          end

          describe ".available_event_names" do
            subject do
              described_class.available_event_names
            end

            it { should match_array EXPECTED_AVAILABLE_EVENT_NAMES }
          end

          describe "#ping" do
            subject do
              service.ping
            end

            it "sends message with proper attachments" do
              expect(service).to receive(:send_message) do |request_body|
                expect(request_body).to match_slack_attachments_request
              end.once
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
                service.public_send(event_name, public_send("#{event_name}_event"))
              end

              it "sends message with proper attachments" do
                expect(service).to receive(:send_message) do |request_body|
                  expect(request_body).to match_slack_attachments_request
                end.once
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
      end
    end
  end
end
