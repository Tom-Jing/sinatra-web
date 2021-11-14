#!/usr/bin/env ruby
require "sinatra"
require "dm-core"
require "dm-migrations"
require_relative 'routers'
require_relative 'player'


configure :development do
    DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/player.db")
end

configure :production do
    DataMapper.setup(:default, ENV['DATABASE_URL'])
end