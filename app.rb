require 'libraries'

module PapertrailSilverlineWebhook
  class App < Sinatra::Base

    dir = File.dirname(File.expand_path(__FILE__))

    set :root,     RACK_ROOT
    set :app_file, __FILE__

    get '/' do
      'hello'
    end

    post '/submit' do
      payload = HashWithIndifferentAccess.new(Yajl::Parser.parse(params[:payload]))

      redis_key = [ 'counter', params[:user], params[:token], params[:name] ].join(':')
      count = Redis.current.incrby(payload[:events].length)

      result = silverline.post 'metrics.json' do |req|
        req.body = {
          :counters => {
            params[:name] => {
              :value => count
            }
          }
        }
      end

      result.success? ? 'ok' : 'error'
    end

    def silverline
      @silverline ||= begin
        options = {}
        options[:timeout] ||= 6

        # Make SSL work on heroku
        if File.exists?('/usr/lib/ssl/certs/ca-certificates.crt')
          options[:ssl] ||= {}
          options[:ssl][:ca_file] = '/usr/lib/ssl/certs/ca-certificates.crt'
        end

        options[:url]  = "https://metrics-api.librato.com/v1"

        Faraday.new(options) do |b|
          b.request :url_encoded
          b.request :json
          b.adapter :net_http
        end.tap do |c|
          c.basic_auth params[:user], params[:token]
          c.headers[:content_type] = 'application/json'
        end
      end
    end
  end
end