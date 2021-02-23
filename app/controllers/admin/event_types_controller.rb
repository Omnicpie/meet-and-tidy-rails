module Admin
  class EventTypesController < AdminController
    before_action :set_event_type, only: [:edit, :update, :destroy]

    def index
      @event_types = EventType.order(:name)
    end

    def new
      @event_type = EventType.new
    end

    def create
      @event_type = EventType.new(event_type_params)

      if @event_type.save
        flash[:notice] = "Added new event type."
        redirect_to admin_event_types_path
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @event_type.update(event_type_params)
        flash[:notice] = "Event type updated."
        redirect_to admin_event_types_path
      else
        render :edit
      end
    end

    def destroy
      @event_type.destroy
      redirect_to admin_event_types_path, notice: "Event type deleted."
    end

    private

    def set_event_type
      @event_type = EventType.find(params[:id])
    end

    def event_type_params
      params.require(:event_type).permit(:name)
    end
  end
end
