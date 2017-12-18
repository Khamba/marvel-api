require "test_helper"
require "marvel/api/list"
require 'yaml'

describe Marvel::Api::Resource do
  before do
    keys = YAML.load_file('test/fixtures/keys.yml')
    marvel = Marvel::Api::Client.new(apikey: keys['apikey'], private_key: keys['private_key']) 
    VCR.insert_cassette 'characters', record: :new_episodes
    @character = marvel.character(1011334)
  end

  after do
    VCR.eject_cassette
  end

  it "is a resource" do
    @character.must_be_kind_of Marvel::Api::Resource
  end

end