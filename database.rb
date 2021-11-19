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
    @conn.exec(query) #глянь на метод exec_params — он предотвращает sql инъекции
  rescue StandardError => e
    puts "Error: cannot execute the query: #{query}.\n#{e}"
  end

  def self.execute_with_result(query)
    puts "DB query: #{query}"
    @conn.exec(query) do |result|
      case result.num_tuples
      when 0 then false
      when 1
        # return one row as hash {"id"=>"1", "firstname"=>"...", "lastname"=>"...", "year_salary"=>"..."}
        fields = result.fields
        values = result.values[0]
        Hash[fields.zip values]
      else
        data = []
        result.each { |row| data << row }
        data
      end
    end
  rescue StandardError => e
    puts "Error: cannot execute the query: #{query}.\n#{e}"
  end
end
