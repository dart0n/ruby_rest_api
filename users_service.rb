require "./users_repository.rb"

class UsersService
  def self.create(data)
    firstname, lastname, year_salary = data[:firstname], data[:lastname], data[:year_salary]

    if firstname and lastname and year_salary
      UsersRepostory.create(firstname, lastname, year_salary)
    else
      puts "Invalid data: firstname: #{firstname}, lastname: #{lastname}, year_salary: #{year_salary}"
    end
  end

  def self.getUsers
    UsersRepostory.getUsers
  end
end
