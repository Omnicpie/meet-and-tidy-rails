module Types
  class MutationType < Types::BaseObject
    field :create_account, mutation: Mutations::CreateAccount
  end
end
