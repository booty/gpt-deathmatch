# frozen_string_literal: true

# Convenience wrappers for database access
class Db
  def self.execute(sql)
    ActiveRecord::Base.connection.execute(sql)
  end

  def self.select_all(sql)
    ActiveRecord::Base.connection.select_all(sql)
  end

  def self.select_values(sql)
    ActiveRecord::Base.connection.select_values(sql)
  end
end
