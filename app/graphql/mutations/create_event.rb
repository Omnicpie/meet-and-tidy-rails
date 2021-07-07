class Mutations::CreateEvent < Mutations::BaseMutation
  null true

  argument :date, String, required: false
  argument :description, String, required: false
  argument :event_type_id, ID, required: true
  argument :facility_ids, [ID], required: true
  argument :location, String, required: false
  argument :title, String, required: true
  argument :url, String, required: false

  field :errors, [String], null: false

  def resolve(date:, description:, event_type_id:, facility_ids:, location:, title:, url:)
    event = Event.new(
      date: date,
      description: description,
      event_type_id: event_type_id,
#      facility_id: facility_id,
      location: location,
      title: title,
      url: url,
    )
    facility_ids.each do |facility_id|
      if (facility = Facility.find_by(id: facility_id))
        event.facilities << facility
      end
    end
    if event.save
      {
        errors: []
      }
    else
      {
        errors: event.errors.full_messages
      }
    end
  end
end
