require_relative './user'

class UsersService
  def self.create(req)
    firstname = req.fetch(:firstname)
    lastname = req.fetch(:lastname)
    year_salary = req.fetch(:year_salary)

    if firstname && lastname && year_salary
      new_user = User.create(firstname, lastname, year_salary)
      { code: 201, data: new_user }
    else
      puts "Invalid data: firstname: #{firstname}, lastname: #{lastname}, year_salary: #{year_salary}"
    end
  end

  def self.all
    { data: User.all }
  end

  def self.update(id, req)
    firstname = req.fetch(:firstname)
    lastname = req.fetch(:lastname)
    year_salary = req.fetch(:year_salary)

    result = User.find_by_id(id)
    unless result
      return { code: 404, data: { error: "User with id #{id} doesn't exist" } }
    end

    user = User.new firstname, lastname, year_salary
    updated_user = user.update(id, firstname, lastname, year_salary)
    { data: updated_user }
  end

  def self.destroy(id)
    result = User.find_by_id(id)
    unless result
      return { code: 404, data: { error: "User with id #{id} doesn't exist" } }
    end

    User.destroy(id)
    { data: { message: "User with id #{id} was deleted" } }
  end

  def self.order(sort_option)
    field, order_type = sort_option.split('_')
    field = 'year_salary' if field == 'salary'

    users = User.order(field, order_type)
    { data: users }
  end
end
