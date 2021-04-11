require_relative './users_service'

class UsersController
  def self.create(req)
    UsersService.create(req[:body])
  end

  def self.index
    UsersService.users
  end
end
