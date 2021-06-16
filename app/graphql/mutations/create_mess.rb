class Mutations::CreateMess < Mutations::BaseMutation
  null true

  argument :description, String, required: false
  argument :location, String, required: false
  argument :mess_type_id, ID, required: true
  argument :title, String, required: true

  field :errors, [String], null: false

  def resolve(description:, location:, mess_type_id:, title:)
    mess = Mess.new(
      description: description,
      location: location,
      mess_type_id: mess_type_id,
      title: title,
    )
    if mess.save
      {
        errors: []
      }
    else
      {
        errors: mess.errors.full_messages
      }
    end
  end
end
