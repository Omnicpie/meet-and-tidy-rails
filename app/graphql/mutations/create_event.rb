class Mutations::CreateEvent < Mutations::BaseMutation
  null true

  argument :description, String, required: false
  argument :event_type_id, ID, required: true
  argument :facility_ids,[ID], required: true
  argument :image_base64, String, required: false
  argument :location, String, required: false
  argument :starts_at, String, required: false
  argument :title, String, required: true
  argument :url, String, required: false

  field :image_urls, [String], null: true

  field :errors, [String], null: false

  def resolve(description:, event_type_id:, facility_ids:, image_base64:, location:, starts_at:, title:, url:)
    event = Event.new(
      description: description,
      event_type_id: event_type_id,
      location: location,
      starts_at: starts_at,
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
    if image_base64.present?
      decoded_data = Base64.decode64(image_base64)

      event.images.attach({
        io: StringIO.new(decoded_data),
        content_type: "image/jpeg",
        filename: "image.jpg"
      })
    end
  end
end
