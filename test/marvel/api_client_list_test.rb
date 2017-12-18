require "test_helper"
require "marvel/api/list"
require 'yaml'

describe Marvel::Api::List do
  before do
    keys = YAML.load_file('test/fixtures/keys.yml')
    marvel = Marvel::Api::Client.new(apikey: keys['apikey'], private_key: keys['private_key']) 
    VCR.insert_cassette 'characters', record: :new_episodes
    @characters = marvel.characters
  end

  after do
    VCR.eject_cassette
  end

  it "has default limit" do
    @characters.limit.must_be_kind_of Integer
    @characters.limit.must_equal @characters['limit'].to_i
  end

  it "has default offset" do
    @characters.offset.must_be_kind_of Integer
    @characters.offset.must_equal @characters['offset'].to_i
  end

  it "has default total" do
    @characters.total.must_be_kind_of Integer
    @characters.total.must_equal @characters['total'].to_i
  end

  it "can paginate #next" do
    @characters.next.must_be_kind_of Marvel::Api::List
  end

  it "can paginate #prev" do
    @characters.prev.must_be_kind_of Marvel::Api::List
  end

end