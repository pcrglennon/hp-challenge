require 'bundler/setup'
require 'active_record'
require 'yaml'

Bundler.require

# Require models
Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}

# Setup DB connection
CONNECTION_DETAILS = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(CONNECTION_DETAILS)