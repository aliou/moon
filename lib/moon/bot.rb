require 'rubygems'
require 'redis'
require 'twitter'

module Moon
  class Bot
    FILE = 'moon.txt'
    def run
      data = File.read FILE
      lines = data.split "----\n"
      lines.shift

      idx = index
      puts lines[idx]
      save!(idx + 1)
    end

    private
    def index
      Moon.redis.get('index').to_i or 0
    end

    def save!(index)
      Moon.redis.set 'index', index
    end
  end
end
