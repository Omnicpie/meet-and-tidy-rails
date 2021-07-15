module Admin
  class UsersController < AdminController
    before_action :set_user, only: [:edit, :update, :destroy]

    def index
      @users = User.order(:name)
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)

      if @user.save
        flash[:notice] = "Added new user."
        redirect_to admin_users_path
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @user.update(user_params)
        flash[:notice] = "User updated."
        redirect_to admin_users_path
      else
        render :edit
      end
    end

    def destroy
      @user.destroy
      redirect_to admin_users_path, notice: "User deleted."
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(
        :email, :name, :password
      )
    end
  end
end
