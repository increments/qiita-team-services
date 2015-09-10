require "active_support/concern"
require "action_view/helpers"

module Qiita::Team::Services
  module Helpers
    module HookHelper
      extend ActiveSupport::Concern

      included do
        shared_examples "hook" do
          describe ".service_name" do
            subject do
              described_class.service_name
            end

            it { should be_a String }
          end

          describe ".render_form" do
            subject do
              extend ActionView::Helpers::FormHelper
              extend ActionView::Helpers::FormTagHelper
              extend ActionView::Helpers::FormOptionsHelper
              described_class.render_form(binding)
            end

            it { should be_a String }
          end
        end
      end
    end
  end
end
