require_relative './user'

class UsersService
  def self.create(firstname, lastname, year_salary)
    User.create(firstname, lastname, year_salary)
  end

  def self.all
    User.all
  end

  def self.update(id, firstname, lastname, year_salary)
    result = User.find_by_id(id)
    return false unless result

    User.update(id, firstname, lastname, year_salary)
  end

  def self.destroy(id)
    result = User.find_by_id(id)
    return false unless result

    User.destroy(id)
    { message: "User with id #{id} was deleted" }
  end

  def self.order(sort_option)
    field, order_type = sort_option.split('_')
    field = 'year_salary' if field == 'salary'

    User.order(field, order_type)
  end
end
