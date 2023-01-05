# borrowed from: http://calicowebdev.com/2011/01/25/rails-3-sqlite-3-in-memory-databases/
def in_memory_database?
  return unless Rails.env.test?
  return unless ActiveRecord::Base.connection.instance_of?(ActiveRecord::ConnectionAdapters::SQLite3Adapter)
  return unless Rails.configuration.database_configuration["test"]["database"] == ":memory:"

  true
end

if in_memory_database?
  puts "creating sqlite in memory database, bro"
  load "#{Rails.root}/db/schema.rb"
end
