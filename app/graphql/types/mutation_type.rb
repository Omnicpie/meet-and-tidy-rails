module Types
  class MutationType < Types::BaseObject
    field :create_account, mutation: Mutations::CreateAccount
    field :create_attend, mutation: Mutations::CreateAttendance
    field :create_event, mutation: Mutations::CreateEvent
    field :create_mess, mutation: Mutations::CreateMess
  end
end
