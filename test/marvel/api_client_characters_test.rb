require "test_helper"
require "marvel/api/list"
require 'yaml'

describe '#characters' do
  before do
    keys = YAML.load_file('test/fixtures/keys.yml')
    @marvel = Marvel::Api::Client.new(apikey: keys['apikey'], private_key: keys['private_key'])
    VCR.insert_cassette 'characters', record: :new_episodes
  end

  after do
    VCR.eject_cassette
  end

  it "records the characters API call as a fixture" do
    @marvel.characters
  end

  it "must return a hash" do
    @marvel.characters.must_be_kind_of Marvel::Api::List
  end

  it "must have an etag" do
    refute_nil @marvel.characters['etag']
  end

end