require 'dm-core'
require 'dm-migrations'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/player.db")

class Player
  include DataMapper::Resource
  property :username, String, :key => true
  property :password, String
  property :totalWin, Integer
  property :totalLost, Integer
  property :totalProfit, Integer
end

DataMapper.finalize
DataMapper.auto_upgrade!

