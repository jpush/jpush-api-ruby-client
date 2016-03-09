require 'webmock/minitest'

module Jpush
  module Utils
    class HttpTest < Jpush::Test

      def setup
        @test_url = 'https://test.com/'
      end

      def test_new_http_client_with_invalid_http_verb
        stub_request(:any, @test_url)

        assert_raises Exception do
          Http.new(:http, @test_url)
        end
      end

      def test_http
        stub_request(:get, 'http://test.com/')

        response = Http.new(:get, 'http://test.com/').send_request
        assert_equal '200', response.code
      end

      def test_any_http_verb
        stub_request(:any, @test_url)

        response = Http.new(:get, @test_url).send_request
        assert_equal '200', response.code

        response = Http.new(:post, @test_url).send_request
        assert_equal '200', response.code

        response = Http.new(:put, @test_url).send_request
        assert_equal '200', response.code

        response = Http.new(:delete, @test_url).send_request
        assert_equal '200', response.code
      end

      def test_get_request
        stub_request(:get, @test_url).
          with(query: { p: 'p' }).
          to_return(body: 'Hello JPush', status: [ 222, 'Hello' ], headers: { 'content-type': 'jpush' })

        assert_raises Exception do
          response = Http.new(:get, @test_url).send_request
        end

        stub_request(:get, @test_url)
        response = Http.new(:get, @test_url).send_request
        assert_equal '200', response.code

        assert_raises Exception do
          Http.new(:post, @test_url).send_request
        end

        assert_raises Exception do
          Http.new(:get, @test_url, params: { p: 'q' }).send_request
        end

        response = Http.new(:get, @test_url, params: { p: 'p' } ).send_request
        assert_equal '222', response.code
        assert_equal 'Hello JPush', response.body
        assert_equal 'Hello', response.message
        assert_equal 'jpush', response['content-type']
      end

      def test_post_request_without_any_params
        stub_request(:post, @test_url)

        response = Http.new(:post, @test_url).send_request
        assert_equal '200', response.code
      end

    end
  end
end
