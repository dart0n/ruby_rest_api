require './database'

class UsersRepostory
  @table = 'users'

  def self.create(firstname, lastname, year_salary)
    Database.execute_with_result(
      "insert into #{@table} (firstname, lastname, year_salary)" \
      "values ('#{firstname}', '#{lastname}', #{year_salary}) returning *"
    )
  end

  def self.all
    Database.execute_with_result("select * from #{@table}")
  end

  def self.find_by_id(id)
    Database.execute_with_result("select * from #{@table} where id = #{id}")
  end

  def self.update(id, firstname, lastname, year_salary)
    Database.execute_with_result(
      "update #{@table} " \
      "set firstname = '#{firstname}', lastname = '#{lastname}', year_salary = #{year_salary} " \
      "where id = #{id} returning *"
    )
  end

  def self.destroy(id)
    Database.execute("delete from #{@table} where id = #{id}")
  end

  def self.order(field, order_type)
    Database.execute_with_result("select * from #{@table} order by #{field} #{order_type}")
  end
end
