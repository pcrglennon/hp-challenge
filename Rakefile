require_relative 'config/environment'
require_relative 'app/cli'

desc "run the Command Line Interface"
task :run do
  cli = Cli.new
  cli.run
end

namespace :db do

  desc "run all migrations in db/migrate"
  task :migrate do
    ActiveRecord::Migrator.migrate("db/migrate/")
  end

  desc "drop the DB"
  task :drop do
    db_file = CONNECTION_DETAILS.fetch("database")
    File.delete(db_file) if File.exist?(db_file)
  end

  desc "drop the DB and re-migrate"
  task :reset => [:drop, :migrate]

end