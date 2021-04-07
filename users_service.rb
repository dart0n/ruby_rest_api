require './users_repository'

class UsersService
  def self.create(data)
    firstname = data.fetch(:firstname)
    lastname = data.fetch(:lastname)
    year_salary = data.fetch(:year_salary)

    if firstname && lastname && year_salary
      UsersRepostory.create(firstname, lastname, year_salary)
    else
      puts "Invalid data: firstname: #{firstname}, lastname: #{lastname}, year_salary: #{year_salary}"
    end
  end

  def self.users
    UsersRepostory.users
  end
end
