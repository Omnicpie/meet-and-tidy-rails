module Admin
  class MessTypesController < AdminController
    before_action :set_mess_type, only: [:edit, :update, :destroy]

    def index
      @mess_types = MessType.order(:name)
    end

    def new
      @mess_type = MessType.new
    end

    def create
      @mess_type = MessType.new(mess_type_params)

      if @mess_type.save
        flash[:notice] = "Added new event type."
        redirect_to admin_mess_types_path
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @mess_type.update(mess_type_params)
        flash[:notice] = "Event type updated."
        redirect_to admin_mess_types_path
      else
        render :edit
      end
    end

    def destroy
      @mess_type.destroy
      redirect_to admin_mess_types_path, notice: "Event type deleted."
    end

    private

    def set_mess_type
      @mess_type = MessType.find(params[:id])
    end

    def mess_type_params
      params.require(:mess_type).permit(:name)
    end
  end
end
