require "erb"

require "active_model"

require "qiita/team/services/hooks"
require "qiita/team/services/hooks/concerns/event_handlable"
require "qiita/team/services/hooks/concerns/persistable"
require "qiita/team/services/hooks/concerns/service"

module Qiita::Team::Services
  module Hooks
    # @abstract
    class Base
      include ActiveModel::Validations
      include Concerns::EventHandlable
      include Concerns::Persistable
      include Concerns::Service

      class << self
        # @param attr [String]
        # @return [String]
        def human_attribute_name(attr, _options = {})
          I18n.t("qiita.team.services.hooks.#{service_type}.#{attr}")
        end

        # @return [String]
        def render_form(binding)
          ERB.new(form_template).result(binding)
        end

        private

        def inherited(child)
          super
          Hooks.all_hooks << child
        end

        # @return [String]
        def form_template
          File.read(File.expand_path("../../templates/#{service_type}.html.erb", __FILE__))
        end
      end
    end
  end
end
