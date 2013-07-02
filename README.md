# Cinch::Storage

[![Gem Version](https://badge.fury.io/rb/cinch-storage.png)](http://badge.fury.io/rb/cinch-storage)
[![Dependency Status](https://gemnasium.com/bhaberer/cinch-storage.png)](https://gemnasium.com/bhaberer/cinch-storage)
[![Build Status](https://travis-ci.org/bhaberer/cinch-storage.png?branch=master)](https://travis-ci.org/bhaberer/cinch-storage)
[![Coverage Status](https://coveralls.io/repos/bhaberer/cinch-storage/badge.png?branch=master)](https://coveralls.io/r/bhaberer/cinch-storage?branch=master)
[![Code Climate](https://codeclimate.com/github/bhaberer/cinch-storage.png)](https://codeclimate.com/github/bhaberer/cinch-storage)

Simple YAML backed Storage solution for Cinch plugins.

Warning: Once Cinch's author finishes Cinch::Storage I will deprecate this gem.

## Installation

Add this line to your application's Gemfile:

    gem 'cinch-storage'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cinch-storage

## Usage

In your plugin you will need to spin up a Storage object as part of your init.

    def initialize(*args)
      super
      @storage = CinchStorage.new('yaml/plugin_name.yml')
      @storage.data ||= {}
    end

Then once you add or alter data and you want to write it out to the file you
can call `Storage#save`, but be sure to wrap it in a synchronize to avoid
data collision.

    synchronize(:plugin_name_save) do
      @storage.save
    end

## This is Horrible Code!

The module is very fragile at the moment as a result of being written in like 20 minutes
or something as a stopgap.

However, since it doesn't look like Cinch::Storage will be happening very soon I will
be going back through and adding tests and error handling and proper debugging and a
little tighter integration with Cinch.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
