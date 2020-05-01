require 'simplecov'
SimpleCov.start do
  add_filter 'test'
  add_filter 'Rakefile'
end
if ENV['CI'] == 'true'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end
require "minitest/autorun"
