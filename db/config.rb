# ref: https://github.com/Ramaze/ramaze/wiki/Setting-up-sequel-sqlite3
require 'sequel'
require 'fileutils'

APP_NAME = 'ticket-booth'

module Database
  DB_MODES = %w[dev prod test]
  DB_DIR = File.expand_path('data', File.dirname(__FILE__))

  FileUtils.mkdir_p DB_DIR

  def self.url(mode)
    raise "Unsupported runtime mode: #{mode.inspect}" unless DB_MODES.include?(mode.to_s)
    "sqlite://#{DB_DIR}/#{APP_NAME}-#{mode.to_s}.db"
  end
end
