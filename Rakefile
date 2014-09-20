require_relative './config/environment'

desc "run the Command Line Interface"
task :run do
  require_relative './app/cli'
  cli = Cli.new
  cli.run
end

desc "start a pry session"
task :console do
  require 'pry'
  Pry.start
end

namespace :db do

  desc "run all migrations in db/migrate"
  task :migrate do
    ActiveRecord::Migrator.migrate("db/migrate/")
  end

  desc "drop the DB"
  task :drop do
    db_file = CONNECTION_DETAILS["development"].fetch("database")
    File.delete(db_file) if File.exist?(db_file)
  end

  desc "seed the DB with code in db/seeds.rb"
  task :seed => [:migrate] do
    load('./db/seeds.rb') if File.exist?('./db/seeds.rb')
  end

  desc "drop the DB and re-migrate"
  task :reset => [:drop, :migrate, :seed]

end