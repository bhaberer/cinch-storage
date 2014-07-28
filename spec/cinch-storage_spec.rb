require 'spec_helper'

Thing = Struct.new(:foo)

class MyPlugin
  include Cinch::Plugin

  def initialize(*args)
    super
    @storage = Cinch::Storage.new(config[:filename] || '/dev/null', [])
  end


  match /store (.*)/,       method: :store_text
  match /storething (.*)/,  method: :store_object

  def store_text(m, text)
    @storage.data << text
    @storage.synced_save(@bot)
  end

  def store_object(m, text)
    @storage.data << Thing.new(text)
    @storage.synced_save(@bot)
  end
end


describe Cinch::Storage do
  include Cinch::Test

  before(:each) do
    @filename = '/tmp/storage_test.tmp'
    File.delete(@filename) if File.exist?(@filename)
    @bot = make_bot(MyPlugin, { filename: @filename })
  end

  it 'should allow users to store information between bot runs' do
    storage = Cinch::Storage.new(@filename, [])
    storage.data << 'foo'
    storage.save

    expect(Cinch::Storage.new(@filename).data)
      .to include('foo')
  end

  it 'should handle multiple bot threads attempting to write to the same file' do
    10.times { |x| get_replies(make_message(@bot, "!store #{x}")) }
    expect(Cinch::Storage.new(@filename).data.length).to eq(10)
  end

  it 'should write object data to the disk' do
    get_replies(make_message(@bot, "!storething foobar"))
    expect(Cinch::Storage.new(@filename).data.first).to eq(Thing.new('foobar'))
  end
end
