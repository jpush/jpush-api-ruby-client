$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'jpush'

require 'minitest/autorun'

conf =
  if File.exist? conf_file = File.expand_path('../config.yml', __FILE__)
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

# 检查必需的配置是否存在
if $test_app_key.nil? || $test_app_key.empty?
  puts "Warning: app_key is not set. Please set the 'app_key' environment variable or modify test/config.yml"
end

if $test_master_secret.nil? || $test_master_secret.empty?
  puts "Warning: master_secret is not set. Please set the 'master_secret' environment variable or modify test/config.yml"
end

$test_common_rid = conf['common_rid']
$test_common_registration_id = conf['common_rid']
$test_android_rid = conf['android_rid']
$test_ios_rid = conf['ios_rid']
$test_hmos_rid = conf['hmos_rid']
$test_common_tag = conf['common_tag']
$test_common_alias = conf['common_alias']
$test_report_delay_time = conf['report_delay_time'].to_i

class JPush::Test < Minitest::Test

  @@jpush = JPush::Client.new($test_app_key, $test_master_secret)

  def assert_true(statement)
    assert_equal true, statement
  end

  def assert_false(statement)
    assert_equal false, statement
  end

end
