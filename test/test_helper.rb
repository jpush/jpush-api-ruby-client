$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'jpush'

require 'minitest/autorun'
require 'webmock/minitest'
require 'yaml'

using Jpush::Utils::Helper::ObjectExtensions

conf =
  if File.exists? conf_file = File.expand_path('../config.yml', __FILE__)
    YAML.load_file(conf_file).jpush_symbolize_keys!
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
$test_repoer_delay_time = conf[:repoer_delay_time].to_i

class Jpush::Test < MiniTest::Test

  # Allow external requests in the whitelist.
  # It will raise an exception for unregistered request by WebMock.
  allowed_sites = [ 'api.jpush.cn', 'device.jpush.cn', 'report.jpush.cn' ]
  WebMock.disable_net_connect!(allow: allowed_sites)

  @@jPush = Jpush::Config.init($test_app_key, $test_master_secret)

  def assert_true(statement)
    assert_equal true, statement
  end

  def assert_false(statement)
    assert_equal false, statement
  end

end
