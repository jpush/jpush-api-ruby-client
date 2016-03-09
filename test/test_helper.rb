$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'jpush'

require 'minitest/autorun'

class Jpush::Test < MiniTest::Test
  def assert_true(statement)
    assert_equal true, statement
  end
end
