module Admin
  class FacilitiesController < AdminController
    before_action :set_facility, except: [:index, :new, :create]

    def index
      @facilities = Facility.order(:name)
    end

    def new
      @facility = Facility.new
    end

    def create
      @facility = Facility.new(facility_params)

      if @facility.save
        flash[:notice] = "Added new facility."
        redirect_to admin_facilities_path
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @facility.update(facility_params)
        flash[:notice] = "Facility updated."
        redirect_to admin_facilities_path
      else
        render :edit
      end
    end

    def destroy
      @facility.destroy
      redirect_to admin_facilities_path, notice: "Facility deleted."
    end

    private

    def set_facility
      @facility = Facility.find_by(id: params[:id])
      not_found unless @facility
    end

    def facility_params
      params.require(:facility).permit(:name)
    end
  end
end
