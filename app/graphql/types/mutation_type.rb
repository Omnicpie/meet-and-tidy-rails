module Types
  class MutationType < Types::BaseObject
    field :create_account, mutation: Mutations::CreateAccount
    field :create_attendance, mutation: Mutations::CreateAttendance
    field :create_event, mutation: Mutations::CreateEvent
  end
end
