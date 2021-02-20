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

Administrator.create!(
  email: "tidy@example.com",
  name: "Tidy",
  password: "top-secret"
)

event_type_a = EventType.create!(
  name: "Park"
)

event_type_b = EventType.create!(
  name: "Urban"
)

Event.create!(
  name: "Urban Park Clean up!",
  event_types: [event_type_a, event_type_b],
)
