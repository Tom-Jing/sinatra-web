#!/usr/bin/env ruby
require "sinatra"
require "sinatra/reloader"
require "dm-core"
require "dm-migrations"
require_relative 'routers'
require_relative 'player'