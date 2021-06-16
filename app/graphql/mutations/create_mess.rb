class Mutations::CreateMess < Mutations::BaseMutation
  null true

  argument :description, String, required: false
  argument :location, String, required: false
  argument :title, String, required: true

  field :errors, [String], null: false

  def resolve(description:, location:, title:)
    mess = Mess.new(
      description: description,
      location: location,
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
