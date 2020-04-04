# ref: https://github.com/Ramaze/ramaze/wiki/Setting-up-sequel-sqlite3

module Database
  DB_MODES = %w[development production test]

  def self.url(mode)
    # if ENV['DATABASE_URL'] && ENV['DATABASE_URL'].length > 0
    ENV.fetch('DATABASE_URL') do
      raise "Unsupported runtime mode: #{mode.inspect}" unless DB_MODES.include?(mode.to_s)
      password = ENV['DB_PASSWORD'] && ENV['DB_PASSWORD'].length > 0 ? ":#{ENV['DB_PASSWORD']}" : ''
      port = ENV['DB_PORT'] && ENV['DB_PORT'].length > 0 ? ":#{ENV['DB_PORT']}" : ''
      "postgres://#{ENV["DB_USER"]}#{password}@#{ENV["DB_HOST"]}#{port}/#{ENV["DB_NAME"]}-#{mode}"
    end
  end
end
