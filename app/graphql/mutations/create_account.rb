class Mutations::CreateAccount < Mutations::BaseMutation
  null true

  argument :name, String, required: false
  argument :email, String, required: true
  argument :password, String, required: true

  field :errors, [String], null: false

  def resolve(name:, email:, password:)
    user = User.new(name: name, email: email, password: password)
    if user.save
      {
        errors: []
      }
    else
      {
        errors: user.errors.full_messages
      }
    end
  end
end
