class UsersService
  def self.create(data)
    firstname, lastname, year_salary = data[:firstname], data[:lastname], data[:year_salary]

    if firstname and lastname and year_salary
      # create
    else
      puts "Invalid data: firstname: #{firstname}, lastname: #{lastname}, year_salary: #{year_salary}"
    end
  end

  def self.getUsers
    [{id: 1, firstname: "foo", lastname: "bar", year_salary: 1000}]
  end
end
