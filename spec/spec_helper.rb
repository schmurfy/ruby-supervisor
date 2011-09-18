
require 'rubygems'
require 'bundler/setup'
require 'rspec'

if (RUBY_VERSION >= "1.9") && ENV['COVERAGE']
  require 'simplecov'
  
  ROOT = File.expand_path('../../', __FILE__)
  
  SimpleCov.start do
   root(ROOT)
  end
end

RSpec.configure do |config|
  config.mock_with :mocha
end
