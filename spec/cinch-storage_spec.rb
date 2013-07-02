require 'spec_helper'

class MyPlugin
  include Cinch::Plugin

  def initialize(*args)
    super
    @storage = CinchStorage.new(config[:filename] || '/dev/null', [])
  end

  match /store (.*)/

  def execute(m, thing)
    @storage.data << thing
    @storage.synced_save(@bot)
  end
end


describe CinchStorage do
  include Cinch::Test

  before(:each) do
    @filename = '/tmp/storage_test.tmp'
    File.delete(@filename) if File.exist?(@filename)
    @bot = make_bot(MyPlugin, { :filename => @filename })
  end

  it 'should allow users to store information between bot runs' do
    storage = CinchStorage.new(@filename, [])
    storage.data << 'foo'
    storage.save

    CinchStorage.new(@filename).data.
      should include 'foo'
  end

  it 'should handle multiple bot threads attempting to write to the same file' do
    10.times { |x| get_replies(make_message(@bot, "!store #{x}"))}
    CinchStorage.new(@filename).data.length.
      should == 10
  end
end
