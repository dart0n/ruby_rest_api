require "./database.rb"

class UsersRepostory
  @@table = "users"

  def self.create(firstname, lastname, year_salary)
    Database.execute(
      "insert into #{@@table} (firstname, lastname, year_salary) values ('#{firstname}', '#{lastname}', #{year_salary})"
    )
  end

  def self.getUsers
    Database.execute_with_result("select * from #{@@table}")
  end
end
