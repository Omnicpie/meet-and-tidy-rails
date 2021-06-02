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
User.destroy_all

Administrator.create!(
  email: "tidy@example.com",
  name: "Tidy",
  password: "top-secret"
)

EventType.create!([
  {name: "Canal"},
  {name: "Cemetery"},
  {name: "Other"},
  {name: "Street"},
  {name: "Woodland"}
])

event_type_a = EventType.create!(
  name: "Park"
)

event_type_b = EventType.create!(
  name: "Urban"
)

event_type_c = EventType.create!(
  name: "Beach"
)

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

Event.create!(
  title: "Urban Park Clean up!",
  event_types: [event_type_a, event_type_b],
  description: "A chance to clean up our local streets and give back to the community.",
  location: "Leeds",
  date: 11-06-2021,
  url: "https://www.google.com"
)

Event.create!(
  title: "Redcar Beach Clean up!",
  event_types: [event_type_c],
  description: "Time to do your part and clean up the beach!",
  location: "Redcar",
  date: 15-12-2021,
  url: "https://www.google.com"
)

Event.create!(
  title: "West Park Clean up!",
  event_types: [event_type_a],
  description: "A chance to clean up our local streets and give back to the community.",
  location: "Goole",
  date: 23-9-2021,
  url: "https://www.google.com"
)

User.create!(
  email: "morty@example.com",
  name: "Morty",
  password: "beeblebrox"
)

User.create!(
  email: "pam@example.com",
  name: "Pam",
  password: "beeblebrox"
)

Mess.create!(
  name: "Bin bags on George St",
  description: "Someone has left all their rubbish on George Street and it needs cleaning up.",
  location: "George Street"
)
