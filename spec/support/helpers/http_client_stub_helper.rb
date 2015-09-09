require "active_support/concern"

module Qiita::Team::Services
  module Helpers
    module HttpClientStubHelper
      extend ActiveSupport::Concern

      # @param service [#http_client]
      def get_http_client_stub(service)
        stubs = Faraday::Adapter::Test::Stubs.new
        http_client = Faraday.new do |faraday|
          faraday.adapter :test, stubs
        end
        allow(service).to receive(:http_client).and_return(http_client)
        stubs
      end
    end
  end
end
