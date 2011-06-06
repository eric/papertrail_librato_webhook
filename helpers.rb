module PapertrailSilverlineWebhook
  module Helpers
    def faraday(options = {})
      @faraday ||= begin
        options[:timeout] ||= 6

        # Make SSL work on heroku
        if File.exists?('/usr/lib/ssl/certs/ca-certificates.crt')
          options[:ssl] ||= {}
          options[:ssl][:ca_path] = '/usr/lib/ssl/certs/ca-certificates.crt'
        end

        Faraday.new(options) do |b|
          b.request :url_encoded
          b.request :json
          b.adapter :net_http
        end
      end
    end
  end
end