require "faraday"
require "faraday_middleware"

module Qiita::Team::Services
  module Hooks
    module Concerns
      module HttpClient
        DEFAULT_ADAPTER = :net_http
        DEFAULT_HEADERS = {
          "Content-Type" => "application/json",
          "User-Agent" => "Qiita:Team",
        }.freeze
        TIMEOUT = 5

        private

        # @return [Faraday::Connection]
        def http_client
          @http_client ||= Faraday.new(faraday_parameters) do |faraday|
            faraday.request request_format
            faraday.adapter adapter
          end
        end

        def faraday_parameters
          {
            headers: DEFAULT_HEADERS,
            request: {
              open_timeout: TIMEOUT,
              timeout: TIMEOUT,
            },
          }
        end

        # @return [String]
        def url
          fail NotImplementedError
        end

        # @param request_body [Hash, Array] request payload.
        # @return [Faraday::Response]
        # @raise [Qiita::Team::Services::DeliveryError]
        def http_post(request_body, headers = {})
          resp = http_client.post do |req|
            req.url url
            req.body = request_body
            request_headers.merge(headers).each_pair do |key, value|
              req.headers[key] = value
            end
          end
          fail DeliveryError unless resp.success?
          resp
        end

        # @return [Symbol] the request format type, `:json` or `:url_encoded`
        def request_format
          :json
        end

        # @return [Hash{String => String}]
        def request_headers
          {}
        end

        def adapter
          DEFAULT_ADAPTER
        end
      end
    end
  end
end
