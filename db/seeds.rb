Administrator.destroy_all
Attendance.destroy_all
Event.destroy_all
EventType.destroy_all
Facility.destroy_all
User.destroy_all

puts "\n== Creating admins =="

Administrator.create!(
  email: "tidy@example.com",
  name: "Tidy",
  password: "top-secret"
)

puts "\n== Creating users =="

user_1 = User.create!(
  email: "morty@example.com",
  name: "Morty",
  password: "secret123"
)

user_2 = User.create!(
  email: "pam@example.com",
  name: "Pam",
  password: "secret123"
)

user_3 = User.create!(
  email: "joe@example.com",
  name: "Joe",
  password: "secret123"
)

user_4 = User.create!(
  email: "tim@example.com",
  name: "Tim",
  password: "secret123"
)

puts "\n== Creating event types =="

EventType.create!([
  {name: "Canal"},
  {name: "Cemetery"},
  {name: "Other"},
  {name: "Street"},
  {name: "Woodland"}
])

event_type_a = EventType.create!(
  name: "Park",
)

event_type_b = EventType.create!(
  name: "Urban"
)

event_type_c = EventType.create!(
  name: "Beach"
)

event_type_d = EventType.create!(
  name: "Fly-tipping"
)

puts "\n== Creating facilities =="

Facility.create!([
  {name: "Toilets"},
  {name: "Parking"},
  {name: "First aiders"},
  {name: "Transport routes"}
])

facility_a = Facility.create!(
  name: "Disabled access"
)

facility_b = Facility.create!(
  name: "Child friendly"
)

puts "\n== Creating events =="

event_1 = Event.create!(
  title: "Urban Park Clean up!",
  event_type: event_type_a,
  description: "A chance to clean up our local streets and give back to the community.",
  facilities: [facility_a, facility_b],
  starts_at: DateTime.current + 1.day,
  location: "Sheffield, UK",
  url: "https://www.google.com"
)

event_2 = Event.create!(
  title: "Redcar Beach Clean up!",
  event_type: event_type_c,
  description: "Time to do your part and clean up the beach!",
  facilities: [facility_a],
  starts_at: DateTime.current + 1.day,
  location: "Doncaster, UK",
  url: "https://www.google.com"
)

event_3 = Event.create!(
  title: "West Park Clean up!",
  event_type: event_type_a,
  description: "A chance to clean up our local streets and give back to the community.",
  facilities: [facility_b],
  starts_at: DateTime.current + 2.days,
  location: "Leeds, UK",
  url: "https://www.google.com"
)

mess_1 = Event.create!(
  title: "Bin bags on George St",
  event_type: event_type_d,
  description: "Someone has left all their rubbish on George Street and it needs cleaning up.",
  location: "York, UK",
  mess: true
)

puts "\n== handling active images =="

def path_for_image(filename)
  "app/assets/images/#{filename}"
end

# ActiveStorage attachments
event_1.images.attach(io: File.open(path_for_image("urban.jpg")), filename: "urban.jpg")
event_1.save!
event_2.images.attach(io: File.open(path_for_image("redcar.jpg")), filename: "redcar.jpg")
event_2.save!
event_3.images.attach(io: File.open(path_for_image("west_park.jpg")), filename: "west_park.jpg")
event_3.save!

# attendances
puts "\n== handling attendance =="

Attendance.create!(
  event: event_1,
  user: user_3
)

Attendance.create!(
  event: event_2,
  user: user_2
)

Attendance.create!(
  event: event_3,
  user: user_2
)

Attendance.create!(
  event: event_2,
  user: user_4
)

Attendance.create!(
  event: event_3,
  user: user_2
)

Attendance.create!(
  event: event_2,
  user: user_1
)
