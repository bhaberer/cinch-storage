require 'cinch/storage/version'
require 'psych'

class CinchStorage

  attr_accessor :filename, :data

  def initialize(file)
    @filename = file
    @data = YAML::load(File.open(@filename)) if File::exist?(@filename)
    @data ||= Hash.new
  end

  def save
    File.open(@filename, 'w') do |file|
      YAML::dump(@data, file)
    end
  end

  def synced_save(bot = @bot)
    bot.synchronize(@filename) do
      save
    end
  end
end

