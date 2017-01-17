$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'jpush'

require 'minitest/autorun'

conf =
  if File.exists? conf_file = File.expand_path('../config.yml', __FILE__)
    require "yaml"
    require "erb"
    template = File.read(conf_file)
    erb_result = ERB.new(template).result
    YAML.load(erb_result)
  else
    raise 'No Conf File Found!!'
  end

$test_app_key = conf['app_key']
$test_master_secret = conf['master_secret']

$test_common_registration_id = conf['common_rid']
$test_common2_registration_id = conf['common2_rid']
$test_android_registration_id = conf['android_rid']
$test_ios_registration_id = conf['ios_rid']

$test_common_tag = conf['tag']
$test_report_delay_time = conf['report_delay_time'].to_i

class JPush::Test < MiniTest::Test

  @@jpush = JPush::Client.new($test_app_key, $test_master_secret)

  def assert_true(statement)
    assert_equal true, statement
  end

  def assert_false(statement)
    assert_equal false, statement
  end

end
