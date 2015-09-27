require 'rubygems'
require 'redis'
require 'twitter'

module Moon
  class Bot
    FILE = 'Moon.txt'

    def run
      data = File.read FILE
      lines = data.split "----\n"
      lines.shift

      reset! if index >= lines.length

      tweet!(lines[index])
      save!(index + 1)
    end

    def reset!
      Moon.redis.del('index')
    end

    private

    def index
      Moon.redis.get('index').to_i or 0
    end

    def tweet!(text)
      if ENV['RACK_ENV'] == 'production'
        Moon.twitter.update(text)
      else
        puts text
      end
    end

    def save!(index)
      Moon.redis.set 'index', index
    end
  end
end
