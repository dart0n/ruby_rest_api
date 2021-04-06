class UsersRepostory
  @@table = "users"

  def self.create(firstname, lastname, year_salary)
    # "insert into #{@@table} (firstname, lastname, year_salary) values ('#{firstname}', '#{lastname}', #{year_salary})"
  end

  def self.getUsers
    # "select * from #{@@table}"
    [{id: 1, firstname: "foo", lastname: "bar", year_salary: 1000}]
  end
end
