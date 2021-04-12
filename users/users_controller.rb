require_relative './users_service'

class UsersController
  attr_accessor :req_data, :error

  def self.create(req)
    return { code: 404, data: @error } unless valid?(req)

    new_user = UsersService.create(@req_data[:firstname], @req_data[:lastname], @req_data[:year_salary])
    { code: 201, data: new_user }
  end

  def self.index
    { data: UsersService.all }
  end

  def self.update(id, req)
    return { code: 404, data: @error } unless valid?(req)

    updated_user = UsersService.update(id, @req_data[:firstname], @req_data[:lastname], @req_data[:year_salary])

    return { code: 404, data: { error: "User with id #{id} doesn't exist" }} unless updated_user
    { data: updated_user }
  end

  def self.destroy(id)
    result = UsersService.destroy(id)
    return { code: 404, data: { error: "User with id #{id} doesn't exist" }} unless result
    { data: result }
  end

  def self.sort(sort_option)
    { data: UsersService.order(sort_option) }
  end

  def self.valid?(req)
    firstname = req.fetch(:firstname)
    lastname = req.fetch(:lastname)
    year_salary = req.fetch(:year_salary).to_i

    if firstname && lastname && year_salary
      @req_data = { firstname: firstname, lastname: lastname, year_salary: year_salary }
      true
    else
      @error = "Invalid data: firstname: #{firstname}, lastname: #{lastname}, year_salary: #{year_salary}"
      false
    end
  end
end
