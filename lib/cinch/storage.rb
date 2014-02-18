# -*- encoding: utf-8 -*-
require 'cinch/storage/version'
require 'psych'

module Cinch
  # Addon for Cinch to allow for simple YAML storage of data
  class Storage
    attr_accessor :filename, :data

    def initialize(file, init = {})
      @filename = file
      @data = Psych.load(File.open(@filename)) if File.exist?(@filename)
      @data ||= init
    end

    def save
      File.open(@filename, 'w') do |file|
        Psych.dump(@data, file)
      end
    end

    def synced_save(bot = @bot)
      bot.synchronize(@filename) do
        save
      end
    end
  end
end
