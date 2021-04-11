require_relative './users_service'

class UsersController
  def self.create(req)
    UsersService.create(req)
  end

  def self.index
    UsersService.all
  end

  def self.update(id, req)
    UsersService.update(id, req)
  end

  def self.destroy(id)
    UsersService.destroy(id)
  end

  def self.sort(sort_option)
    UsersService.order(sort_option)
  end
end
