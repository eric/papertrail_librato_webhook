RACK_ENV  = ENV['RACK_ENV'] || ENV['RAILS_ENV'] || 'development'
RACK_ROOT = File.expand_path(File.dirname(__FILE__) + '/..')

require 'bundler'
Bundler.require :default

require 'sinatra/base'
require 'yajl'
require 'faraday'
require 'active_support'
require 'always_verify_ssl_certificates'

$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))

require 'helpers'
