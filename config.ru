unless $LOAD_PATH.include? "."
  $LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))
end

ENV['REDIS_URL'] ||= ENV['REDISTOGO_URL']

require 'app'

run PapertrailSilverlineWebhook::App.new
