class Mutations::CreateMess < Mutations::BaseMutation
  null true

  argument :description, String
  argument :location, String
  argument :title, String, required: false

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
