module Admin
  class MessesController < AdminController
    before_action :set_mess, only: [:edit, :update, :destroy]

    def index
      @messes = Mess.order(:created_at)
    end

    def new
      @mess = Mess.new
    end

    def create
      @mess = Mess.new(mess_params)

      if @mess.save
        flash[:notice] = "Added new mess."
        redirect_to admin_messes_path
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @mess.update(mess_params)
        flash[:notice] = "Mess updated."
        redirect_to admin_messes_path
      else
        render :edit
      end
    end

    def destroy
      @mess.destroy
      redirect_to admin_messes_path, notice: "Mess deleted."
    end

    private

    def set_mess
      @mess = Mess.find(params[:id])
    end

    def mess_params
      params.require(:mess).permit(
        :description, :location, :title
      )
    end
  end
end
