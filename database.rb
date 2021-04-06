require 'pg'

class Database
  @@dbname = "ruby_task"

  def self.connect
    begin
      @@conn = PG.connect(dbname: @@dbname)
    rescue Exception => e
      puts "Error: cannot connect to DB.\n#{e}"
    end
  end

  def self.execute(query)
    puts "DB query: #{query}"
    begin
      @@conn.exec(query)
    rescue Exception => e
      puts "Error: cannot execute the query: #{query}.\n#{e}"
    end
  end

  def self.execute_with_result(query)
    puts "DB query: #{query}"
    begin
      data = []

      @@conn.exec(query) do |result|
        result.each do |row|
          data << row
        end
      end

      data
    rescue Exception => e
      puts "Error: cannot execute the query: #{query}.\n#{e}"
    end
  end
end
