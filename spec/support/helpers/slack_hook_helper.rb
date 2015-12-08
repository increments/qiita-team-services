require "active_support/concern"

require "support/helpers/event_helper"

module Qiita::Team::Services
  module Helpers
    module SlackHookHelper
      extend ActiveSupport::Concern
      include EventHelper

      EXPECTED_AVAILABLE_EVENT_NAMES = [
        :item_became_coediting,
        :item_comment_created,
        :item_comment_destroyed,
        :item_comment_updated,
        :item_created,
        :item_destroyed,
        :item_updated,
        :project_activated,
        :project_archived,
        :project_comment_created,
        :project_comment_destroyed,
        :project_comment_updated,
        :project_created,
        :project_destroyed,
        :project_updated,
        :team_member_added,
        :team_member_removed,
      ].freeze

      included do
        shared_examples "Slack hook" do |hook:|
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
              send(hook).ping
            end

            it "sends proper text message" do
              expect(send(hook)).to receive(:send_message) do |request_body|
                expect(request_body).to match_slack_text_request
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

          describe "hook methods" do
            shared_examples "hook method" do
              context "when message is delivered successfully" do
                include_context "Delivery success"

                it { expect { subject }.not_to raise_error }
              end

              context "when message is not delivered successfully" do
                include_context "Delivery fail"

                it { expect { subject }.to raise_error(Qiita::Team::Services::DeliveryError) }
              end
            end

            shared_examples "text request hook method" do
              it "sends proper text request message" do
                expect(send(hook)).to receive(:send_message) do |request_body|
                  expect(request_body).to match_slack_text_request
                end.once
                subject
              end
            end

            shared_examples "attachments request hook method" do
              it "sends message with proper attachments" do
                expect(send(hook)).to receive(:send_message) do |request_body|
                  expect(request_body).to match_slack_attachments_request
                end.once
                subject
              end
            end

            subject do
              send(hook).public_send(event_name,
                                     public_send("#{event_name}_event",
                                                 try(:resource), try(:user), try(:team)))
            end

            describe "#item_created" do
              let(:event_name) { "item_created" }
              it_behaves_like "hook method"
              it_behaves_like "attachments request hook method"

              context "when the item's title has angle bracket characters" do
                let(:resource) { build(:item, title: "1 on 1 qiitan <> kobito") }
                it_behaves_like "attachments request hook method"
              end

              context "when the user's name has angle bracket characters" do
                let(:user) { build(:user, name: "<Qiitan>") }
                it_behaves_like "attachments request hook method"
              end
            end

            %w(became_coediting destroyed updated).each do |action_name|
              describe "#item_#{action_name}" do
                let(:event_name) { "item_#{action_name}" }
                it_behaves_like "hook method"
                it_behaves_like "text request hook method"

                context "when the item's title has angle bracket characters" do
                  let(:resource) { build(:item, title: "1 on 1 qiitan <> kobito") }
                  it_behaves_like "text request hook method"
                end

                context "when the user's name has angle bracket characters" do
                  let(:user) { build(:user, name: "<Qiitan>") }
                  it_behaves_like "text request hook method"
                end
              end
            end

            describe "#item_comment_created" do
              let(:event_name) { "item_comment_created" }
              it_behaves_like "hook method"
              it_behaves_like "attachments request hook method"

              context "when the item's title has angle bracket characters" do
                let(:resource) do
                  build(:comment, item: build(:item, title: "1 on 1 qiitan <> kobito"))
                end
                it_behaves_like "attachments request hook method"
              end

              context "when the user's name has angle bracket characters" do
                let(:user) { build(:user, name: "<Qiitan>") }
                it_behaves_like "attachments request hook method"
              end
            end

            %w(destroyed updated).each do |action_name|
              describe "#item_comment_#{action_name}" do
                let(:event_name) { "item_comment_#{action_name}" }
                it_behaves_like "hook method"
                it_behaves_like "text request hook method"

                context "when the item's title has angle bracket characters" do
                  let(:resource) do
                    build(:comment, item: build(:item, title: "1 on 1 qiitan <> kobito"))
                  end
                  it_behaves_like "text request hook method"
                end

                context "when the user's name has angle bracket characters" do
                  let(:user) { build(:user, name: "<Qiitan>") }
                  it_behaves_like "text request hook method"
                end
              end
            end

            %w(activated archived created destroyed updated).each do |action_name|
              describe "#project_#{action_name}" do
                let(:event_name) { "project_#{action_name}" }
                it_behaves_like "hook method"
                it_behaves_like "text request hook method"

                context "when the project's name has angle bracket characters" do
                  let(:resource) { build(:project, name: "1 on 1 project qiitan <> kobito") }
                  it_behaves_like "text request hook method"
                end

                context "when the user's name has angle bracket characters" do
                  let(:user) { build(:user, name: "<Qiitan>") }
                  it_behaves_like "text request hook method"
                end
              end
            end

            describe "#project_comment_created" do
              let(:event_name) { "project_comment_created" }
              it_behaves_like "hook method"
              it_behaves_like "attachments request hook method"

              context "when the project's name has angle bracket characters" do
                let(:resource) do
                  build(:project_comment,
                        item: build(:project, name: "1 on 1 project qiitan <> kobito"))
                end
                it_behaves_like "attachments request hook method"
              end

              context "when the user's name has angle bracket characters" do
                let(:user) { build(:user, name: "<Qiitan>") }
                it_behaves_like "attachments request hook method"
              end
            end

            %w(destroyed updated).each do |action_name|
              describe "#project_comment_#{action_name}" do
                let(:event_name) { "project_comment_#{action_name}" }
                it_behaves_like "hook method"
                it_behaves_like "text request hook method"

                context "when the project's name has angle bracket characters" do
                  let(:resource) do
                    build(:project_comment,
                          item: build(:project, name: "1 on 1 project qiitan <> kobito"))
                  end
                  it_behaves_like "text request hook method"
                end

                context "when the user's name has angle bracket characters" do
                  let(:user) { build(:user, name: "<Qiitan>") }
                  it_behaves_like "text request hook method"
                end
              end
            end

            %w(added removed).each do |action_name|
              describe "#team_member_#{action_name}" do
                let(:event_name) { "team_member_#{action_name}" }
                it_behaves_like "hook method"
                it_behaves_like "text request hook method"

                context "when the team's name has angle bracket characters" do
                  let(:team) do
                    build(:team, name: "qiitan <> kobito team", url: "https://qiitan.qiita.com")
                  end
                  it_behaves_like "text request hook method"
                end

                context "when the user's name has angle bracket characters" do
                  let(:user) { build(:user, name: "<Qiitan>") }
                  it_behaves_like "text request hook method"
                end
              end
            end
          end
        end
      end
    end
  end
end
