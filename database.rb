require 'pg'

class Database
  @dbname = 'ruby_task'

  def self.connect
    @conn = PG.connect(dbname: @dbname)
  rescue StandardError => e
    puts "Error: cannot connect to DB.\n#{e}"
  end

  def self.execute(query)
    puts "DB query: #{query}"
    @conn.exec(query)
  rescue StandardError => e
    puts "Error: cannot execute the query: #{query}.\n#{e}"
  end

  def self.execute_with_result(query)
    puts "DB query: #{query}"
    data = []
    @conn.exec(query) do |result|
      result.each do |row|
        data << row
      end
    end

    data
  rescue StandardError => e
    puts "Error: cannot execute the query: #{query}.\n#{e}"
  end
end
