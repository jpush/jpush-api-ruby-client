$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'jpush'

require 'minitest/autorun'

using JPush::Utils::Helper::ObjectExtensions

conf =
  if File.exists? conf_file = File.expand_path('../config.yml', __FILE__)
    require "yaml"
    require "erb"
    template = File.read(conf_file)
    erb_result = ERB.new(template).result
    YAML.load(erb_result).jpush_symbolize_keys!
  else
    raise 'No Conf File Found!!'
  end

$test_app_key = conf[:app_key]
$test_master_secret = conf[:master_secret]

$test_common_registration_id = conf[:registration_ids][:common]
$test_common2_registration_id = conf[:registration_ids][:common2]
$test_android_registration_id = conf[:registration_ids][:android]
$test_ios_registration_id = conf[:registration_ids][:ios]

$test_common_tag = conf[:tags][:common]
$test_report_delay_time = conf[:report_delay_time].to_i

class JPush::Test < MiniTest::Test

  @@jpush = JPush::Client.new($test_app_key, $test_master_secret)

  def assert_true(statement)
    assert_equal true, statement
  end

  def assert_false(statement)
    assert_equal false, statement
  end

end
