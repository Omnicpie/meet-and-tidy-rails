class Mutations::CreateAttendance < Mutations::BaseMutation
  null true

  argument :user_id, ID, required: true
  argument :event_id, ID, required: true

  field :errors, [String], null: false

  def resolve(user_id:, event_id:)
    attendance = Attendance.new(
      user_id: user_id,
      event_id: event_id,
    )
    if attendance.save
      {
        errors: []
      }
    else
      {
        errors: attendance.errors.full_messages
      }
    end
  end
end
