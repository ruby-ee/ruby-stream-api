require 'simplecov'
SimpleCov.start
if ENV['CI'] == 'true'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "stream.rb"
require "fromarray.rb"
require "minitest/autorun"
