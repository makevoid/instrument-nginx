require "bundler"
Bundler.require :default

class Redis
  alias :[] :get
  alias :[]= :set
end

STDOUT.sync = true

REDIS_HOST_DEFAULT = "redis"
redis_host = ENV["REDIS_HOST"] || REDIS_HOST_DEFAULT
R = Redis.new host: redis_host

puts "test: #{R["test"]}"
