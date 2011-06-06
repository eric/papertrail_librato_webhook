require 'libraries'

module PapertrailSilverlineWebhook
  class App < Sinatra::Base
    include PapertrailSilverlineWebhook::Helpers

    dir = File.dirname(File.expand_path(__FILE__))

    set :root,     RACK_ROOT
    set :app_file, __FILE__

    get '/' do
      puts 'hello'
      'hello'
    end

    post '/submit' do
      payload = HashWithIndifferentAccess.new(Yajl::Parser.parse(params[:payload]))

      count = payload[:events].length
      
      faraday.basic_auth params[:user], params[:token]
      faraday.headers[:content_type] = 'application/json'

      result = faraday.post do |req|
        req.url "https://metrics-api.librato.com/v1/metrics.json"
        req.body = {
          :gauges => {
            params[:name] => {
              :value => count
            }
          }
        }
      end

      puts result.body

      result.success? ? 'ok' : 'error'
    end
  end
end