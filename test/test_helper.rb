require 'simplecov'
SimpleCov.start do
  add_filter 'test'
  add_filter 'Rakefile'
end

require "minitest/autorun"
