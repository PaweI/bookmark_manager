env = ENV["RACK_ENV"] || "development"

# ENV['HEROKU_POSTGRESQL_BLUE_URL'] Database when deploying to Heroku

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")

require_relative "models/link"
require_relative "models/tag"
require_relative "models/user"

DataMapper.finalize

