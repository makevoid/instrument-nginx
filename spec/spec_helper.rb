require 'json'
require 'bundler'
Bundler.require :default

RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = :should }
end

HOST_URL = "localhost"

require_relative "lib/spec_lib"
include SpecLib
