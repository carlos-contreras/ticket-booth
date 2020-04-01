# ref: https://github.com/Ramaze/ramaze/wiki/Setting-up-sequel-sqlite3
require_relative 'db/config'

namespace 'db' do
  desc "Run database migrations where mode is: #{Database::DB_MODES.join(', ')}"
  task :migrate, :mode do |t, args|
    cmd = "sequel -m db/migrations #{Database.url(mode(args[:mode]))}"
    puts cmd
    puts `#{cmd}`
  end

  desc 'Zap the database my running all the down migrations'
  task :zap, [:mode] do |t, args|
    cmd = "sequel -m db/migrations -M 0 #{Database.url(mode(args[:mode]))}"
    puts cmd
    puts `#{cmd}`
  end

  desc 'Reset the database then run the migrations'
  task :reset, [:mode] => [:zap, :migrate]
end

def mode(arg)
  mode = arg
  if mode.nil? || mode.strip.empty?
    mode = 'dev'
  end
  mode.to_sym
end
