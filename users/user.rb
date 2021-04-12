require_relative './users_repository'

class User
  attr_accessor :firstname, :lastname, :year_salary

  def initialize(firstname, lastname, year_salary)
    @firstname = firstname
    @lastname = lastname
    @year_salary = year_salary
  end

  def self.all
    UsersRepostory.all
  end

  def self.create(firstname, lastname, year_salary)
    UsersRepostory.create(firstname, lastname, year_salary)
  end

  def self.update(id, firstname, lastname, year_salary)
    UsersRepostory.update(id, firstname, lastname, year_salary)
  end

  def self.destroy(id)
    UsersRepostory.destroy(id)
  end

  def self.find_by_id(id)
    UsersRepostory.find_by_id(id)
  end

  def self.order(field, order_type)
    UsersRepostory.order(field, order_type)
  end
end
