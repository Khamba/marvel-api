require "test_helper"

describe Marvel::Api::Client do

  def test_must_include_httparty
    Marvel::Api::Client.must_include HTTParty
  end

  def test_base_uri
    Marvel::Api::Client.base_uri.must_equal 'https://gateway.marvel.com/v1/public'
  end

  def test_new_raises_error_on_no_keys
    lambda { Marvel::Api::Client.new() }.must_raise Marvel::Api::MissingKeyError
  end

  def test_new_raises_error_on_only_apikey
    lambda { Marvel::Api::Client.new(apikey: 'test') }.must_raise Marvel::Api::MissingKeyError
  end

  def test_new_raises_error_on_only_private_key
    lambda { Marvel::Api::Client.new(private_key: 'test') }.must_raise Marvel::Api::MissingKeyError
  end

  def test_new_does_not_raise_error_on_both_keys
    marvel = Marvel::Api::Client.new(private_key: 'test', apikey: 'test') # Minitest does not have must_not_raise. I found this better than monkey patching
    refute_nil marvel
  end

  def test_hash
    timestamp = Time.now.to_s
    marvel = Marvel::Api::Client.new(private_key: 'test', apikey: 'test')
    marvel.send(:hash, timestamp).must_equal(Digest::MD5.hexdigest( timestamp + 'test' + 'test' ))
  end
end