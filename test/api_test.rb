require "test_helper"

class StreamApi::ApiTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::StreamApi::VERSION
  end
end
