unless $LOAD_PATH.include? "."
  $LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))
end

require 'app/app'

run PapertrailSilverlineWebhook::App.new
