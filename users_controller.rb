require "./users_service.rb"

class UsersController
  def self.create(req)
    UsersService.create(req[:body])
  end

  def self.index
    UsersService.getUsers
  end
end
