require 'test_helper'

class HolaTest < JPush::Test
  def test_hola_msg
    hola = JPush::Hola.new('Hello JPush')
    assert_equal 'Hello JPush', hola.msg
  end
end
