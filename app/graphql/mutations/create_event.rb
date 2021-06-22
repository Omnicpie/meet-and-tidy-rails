class Mutations::CreateEvent < Mutations::BaseMutation
  null true

  argument :date, String, required: false
  argument :description, String, required: false
  argument :event_type_id, ID, required: true
  argument :facility_id, ID, required: true
  argument :location, String, required: false
  argument :title, String, required: true
  argument :url, String, required: false

  field :errors, [String], null: false

  def resolve(date:, description:, event_type_id:, facility_id:, location:, title:, url:)
    event = Event.new(
      date: date,
      description: description,
      event_type_id: event_type_id,
      facility_id: facility_id,
      location: location,
      title: title,
      url: url,
    )
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
