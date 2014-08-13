require 'rubygems'
require 'redis'

module Moon

  TWITTER_CONSUMER_KEY = ENV['CONSUMER_KEY']
  TWITTER_CONSUMER_SECRET = ENV['CONSUMER_SECRET']
  TWITTER_ACCESS_TOKEN = ENV['OAUTH_TOKEN']
  TWITTER_ACCESS_TOKEN_SECRET = ENV['OAUTH_TOKEN_SECRET']

  module_function
  def redis
    @@redis ||= begin
      uri = URI.parse(ENV["REDISTOGO_URL"])
      Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
    end
  end

  def twitter
    @@client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = TWITTER_CONSUMER_KEY
      config.consumer_secret = TWITTER_CONSUMER_SECRET
      config.access_token = TWITTER_ACCESS_TOKEN
      config.access_token_secret = TWITTER_ACCESS_TOKEN_SECRET
    end
  end
end

require 'moon/bot'
