module Admin
  class UsersController < AdminController
    def index
      @users = User.order(:email)
    end
  end
end
