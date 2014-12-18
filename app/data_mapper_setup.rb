env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, ENV['HEROKU_POSTGRESQL_BLUE_URL'])

require_relative "models/link"
require_relative "models/tag"
require_relative "models/user"

DataMapper.finalize

DataMapper.auto_upgrade!
