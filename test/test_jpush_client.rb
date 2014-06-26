require_relative '../lib/jpush'
require "minitest/autorun"
require 'mocha/mini_test'
require 'base64'

class TestJpushClient < Minitest::Test

  def test_truey
    assert true
  end

  def urlsafe_base64_encode content
    Base64.encode64(content).strip.gsub('+', '-').gsub('/','_').gsub(/\r?\n/, '')
  end

  def setup
    Random.stubs(:rand).returns(100)
    app_key = '466f7032ac604e02fb7bda89' #必填，例如466f7032ac604e02fb7bda89
    master_secret = '57c45646c772983fede7c455' #必填，每个应用都对应一个masterSecret
    @header = { content_type: :json, Authorization: "Basic #{urlsafe_base64_encode(app_key + ':' + master_secret)}" }
    @options = { options: { sendno: Random.rand(10000) }, platform: 'all' }
    @jpush_client = ::JPush::Client.new(app_key, master_secret, { platform: @options[:platform] })
  end

  def test_push
    options = { notification: { alert: 'Hi, JPush'}, audience: ['alias1'] }
    params = @options.merge(options).merge(audience: { alias: ['alias1'] })
    RestClient.stubs(:post).with(::JPush::API_URI, params.to_json, @header)
    @jpush_client.push(options)
  end

  def test_broadcast
    options = { notification: { alert: 'Hi, JPush'} }
    params = @options.merge(options).merge(audience: 'all')
    RestClient.stubs(:post).with(::JPush::API_URI, params.to_json, @header)
    @jpush_client.broadcast_push(options)
  end

  def test_tag_push
    options = { notification: { alert: 'Hi, JPush'}, audience: ['tag1', 'tag2'] }
    params = @options.merge(options).merge(audience: { tag: options[:audience] })
    RestClient.stubs(:post).with(::JPush::API_URI, params.to_json, @header)
    @jpush_client.tag_push(options)
  end

  def test_tag_push_and_tag_and_push
    options = { notification: { alert: 'Hi, JPush'}, audience: { tag: ['tag1', 'tag2'], tag_and: ['tagand1', 'tagand2']}}
    params = @options.merge(options)
    RestClient.stubs(:post).with(::JPush::API_URI, params.to_json, @header)
    @jpush_client.tag_push(options)
  end

  def test_registration_push
    options = { notification: { alert: 'Hi, JPush'}, audience: ['regi1', 'regi2'] }
    params = @options.merge(options).merge(audience: { registration_id: options[:audience] })
    RestClient.stubs(:post).with(::JPush::API_URI, params.to_json, @header)
    @jpush_client.registration_push(options)
  end

  def test_push
    options = { notification: { alert: 'Hi, JPush'} }
    params = @options.merge(options).merge(audience: 'all')
    resp = @jpush_client.broadcast_push(options)
    assert_equal resp.code, 401
  end

end
