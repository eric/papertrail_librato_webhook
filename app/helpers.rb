module PapertrailSilverlineWebhook
  module Helpers
    def faraday(options = {})
      @faraday ||= begin
        options[:timeout] ||= 6
        Faraday.new(options) do |b|
          b.request :url_encoded
          b.request :json
          b.adapter :net_http
        end
      end
    end
  end
end