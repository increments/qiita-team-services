module Qiita::Team::Services
  module Services
    module Concerns
      module HttpClient
        private

        # @return [Faraday::Connection]
        def http_client
          @http_client ||= Faraday.new do |faraday|
            faraday.request :json
            faraday.adapter Faraday.default_adapter
          end
        end

        # @return [String]
        def url
          fail NotImplementedError
        end

        # @param request_body [Hash, Array] request payload.
        # @return [Faraday::Response]
        def http_post(request_body)
          http_client.post(url, request_body)
        end
      end
    end
  end
end
