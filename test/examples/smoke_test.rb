# A standalone Minitest that does not require Rails/DB
require "minitest/autorun"

class SmokeTest < Minitest::Test
  def test_truth
    assert_equal 2, 1 + 1
  end
end
