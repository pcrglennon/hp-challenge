require_relative '../config/environment'
require 'pry'

RSpec.configure do |config|

  # Use separate test DB
  ActiveRecord::Base.establish_connection(CONNECTION_DETAILS["test"])
  ActiveRecord::Migrator.migrate("db/migrate/")

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

end