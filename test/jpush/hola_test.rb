require 'test_helper'

class HolaTest < Jpush::Test
  def test_hola_msg
    hola = Jpush::Hola.new('Hello JPush')
    assert_equal 'Hello JPush', hola.msg
  end
end
