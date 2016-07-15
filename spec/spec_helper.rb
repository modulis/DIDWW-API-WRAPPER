$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'DIDWW'
require 'bundler/setup'
require 'pry'

DIDWW.configure do |config|
  config.api_username = 'test@test.ca'
  config.api_key = 'test_key'
end
