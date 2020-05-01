require 'simplecov'
SimpleCov.start do
  add_filter 'test'
  add_filter 'Rakefile'
end
require 'coveralls'
Coveralls.wear!

require "minitest/autorun"
