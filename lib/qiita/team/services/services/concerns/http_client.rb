module Qiita::Team::Services
  module Services
    module Concerns
      module HttpClient
        private

        # @return [Faraday::Connection]
        def http_client
          @http_client ||= Faraday.new do |faraday|
            faraday.request request_format
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
          http_client.post do |req|
            req.url url
            req.body = request_body
            request_headers.each_pair do |key, value|
              req.headers[key] = value
            end
          end
        end

        # @return [Symbol] the request format type, `:json` or `:url_encoded`
        def request_format
          :json
        end

        # @return [Hash{String => String}]
        def request_headers
          {}
        end
      end
    end
  end
end
