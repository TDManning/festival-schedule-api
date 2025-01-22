# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.destroy_all
Show.destroy_all
UsersShow.destroy_all

# Create test users
users = [
  User.create!(
    username: 'rockstar_rachel',
    first_name: 'Rachel',
    last_name: 'Groove'
  ),
  User.create!(
    username: 'jammin_jake',
    first_name: 'Jake',
    last_name: 'Rhythm'
  ),
  User.create!(
    username: 'dancing_diana',
    first_name: 'Diana',
    last_name: 'Harmony'
  ),
  User.create!(
    username: 'melody_mike',
    first_name: 'Mike',
    last_name: 'Melody'
  ),
  User.create!(
    username: 'vocal_victor',
    first_name: 'Victor',
    last_name: 'Voice'
  ),
  User.create!(
    username: 'drummer_danny',
    first_name: 'Danny',
    last_name: 'Beat'
  )
]

time_slots = [
  "12:00 PM - 1:00 PM",
  "1:30 PM - 2:30 PM",
  "3:00 PM - 4:00 PM",
  "4:30 PM - 5:30 PM",
  "6:00 PM - 7:00 PM"
]

stages = [
  "Main Stage", "River Stage", "Hilltop Stage", "Meadow Stage", 
  "Beach Stage", "Garden Stage", "City Stage"
]

bands = [
  "The Rolling Stones", "Queen", "Fleetwood Mac", "The Beatles", 
  "Nirvana", "Green Day", "Red Hot Chili Peppers", "Arctic Monkeys",
  "Coldplay", "Imagine Dragons", "Linkin Park", "Foo Fighters", 
  "The Killers", "Muse", "Paramore", "Blink-182", "Maroon 5", 
  "The Black Keys", "Panic! At The Disco", "Twenty One Pilots", 
  "Kings of Leon", "The Strokes", "Fall Out Boy", "The Lumineers", 
  "Vampire Weekend", "The 1975", "Of Monsters and Men", "Tame Impala", 
  "MGMT", "The White Stripes"
]

bands.each do |band|
  Show.create!(
    artist: band,
    location: stages.sample,
    time_slot: rand(1..5), # Corrected from "1..5" (invalid syntax) to a valid range
    image_url: "https://via.placeholder.com/150?text=#{band.tr(' ', '+')}"
  )
end

users.each do |user|
  shows = Show.order("RANDOM()").limit(5)
  shows.each do |show|
    UsersShow.create!(
      user: user,
      show: show,
      favorited: [true, false].sample # Ensures favorited is either true or false
    )
  end
end

puts "Seed data created successfully!"
