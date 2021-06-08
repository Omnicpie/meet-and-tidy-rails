# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Administrator.destroy_all
Event.destroy_all
EventType.destroy_all
Facility.destroy_all
Mess.destroy_all
MessType.destroy_all
User.destroy_all

puts "\n== Creating admins =="

Administrator.create!(
  email: "tidy@example.com",
  name: "Tidy",
  password: "top-secret"
)

puts "\n== Creating users =="

User.create!(
  email: "morty@example.com",
  name: "Morty",
  password: "secret123"
)

User.create!(
  email: "pam@example.com",
  name: "Pam",
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

puts "\n== Creating facilities =="

Facility.create!([
  {name: "Toilets"},
  {name: "Parking"},
  {name: "First aiders"},
  {name: "Transport routes"},
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
  location: "Leeds",
  date: 11-06-2021,
  url: "https://www.google.com",
)

event_2 = Event.create!(
  title: "Redcar Beach Clean up!",
  event_type: event_type_c,
  description: "Time to do your part and clean up the beach!",
  facilities: [facility_a],
  location: "Redcar",
  date: 15-12-2021,
  url: "https://www.google.com",
)

event_3 = Event.create!(
  title: "West Park Clean up!",
  event_type: event_type_a,
  description: "A chance to clean up our local streets and give back to the community.",
  facilities: [facility_b],
  location: "Goole",
  date: 23-9-2021,
  url: "https://www.google.com",
)

# puts "\n== Creating mess types =="

# MessType.create!([
#   {name: "Canal"},
#   {name: "Cemetery"},
#   {name: "Other"},
#   {name: "Street"},
#   {name: "Woodland"}
# ])

mess_type_a = MessType.create!(
  name: "Fly-tip"
)

mess_type_b = MessType.create!(
  name: "Rubbish"
)

mess_type_c = MessType.create!(
  name: "Other"
)

puts "\n== Creating messes =="

mess_1 = Mess.create!(
  title: "Bin bags on George St",
  mess_type: mess_type_b,
  description: "Someone has left all their rubbish on George Street and it needs cleaning up.",
  location: "George Street"
)

mess_2 = Mess.create!(
  title: "Fly-tip in alley",
  mess_type: mess_type_a,
  description: "Massive fly-tip on the alley between Carilse and Smitth street.",
  location: "Doncaster"
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
mess_1.images.attach(io: File.open(path_for_image("rubbish.jpg")), filename: "rubbish.jpg")
mess_1.save!
mess_2.images.attach(io: File.open(path_for_image("fly_tip.jpg")), filename: "fly_tip.jpg")
mess_2.save!

