module Admin
  class EventsController < AdminController
    before_action :set_event, except: [:index, :new, :create]

    def index
      @events = Event.order(:title)
    end

    def new
      @event = Event.new
    end

    def create
      @event = Event.new(event_params)

      if @event.save
        flash[:notice] = "Added new event."
        redirect_to admin_events_path
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @event.update(event_params)
        flash[:notice] = "Event updated."
        redirect_to admin_events_path
      else
        render :edit
      end
    end

    def destroy
      @event.destroy
      redirect_to admin_events_path, notice: "Event deleted."
    end

    private

    def set_event
      @event = Event.find_by(id: params[:id])
      not_found unless @event
    end

    def event_params
      params.require(:event).permit(
        :description, :title, :url
      )
    end
  end
end
