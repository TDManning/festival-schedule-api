# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
User.destroy_all
Show.destroy_all
UsersShow.destroy_all

# Create users
users = User.create!([
  { username: 'RockLover', first_name: 'Alice', last_name: 'Smith' },
  { username: 'PopMaster', first_name: 'Bob', last_name: 'Jones' },
  { username: 'StageKing', first_name: 'Carol', last_name: 'Taylor' },
  { username: 'MelodyFan', first_name: 'Dan', last_name: 'Brown' },
  { username: 'BassDropper', first_name: 'Eve', last_name: 'Davis' }
])
puts "Created #{users.count} users"

bands = [
  'Taylor Swift', 'Ed Sheeran', 'Beyoncé', 'Weird Al', 'Adele', 
  'Billie Eilish', 'The Weeknd', 'Bruno Mars', 'Harry Styles', 
  'Ariana Grande', 'Dua Lipa', 'Justin Bieber', 'Lady Gaga', 
  'Post Malone', 'Khalid', 'Shawn Mendes', 'Rihanna', 'Coldplay', 
  'Maroon 5', 'Imagine Dragons'
]

# Create shows (one band per stage for all time slots)
time_slots = (1..5).to_a
shows = []

bands.each_with_index do |band, index|
  stage = "Stage #{index + 1}"

  time_slots.each do |time_slot|
    shows << {
      artist: band,
      location: stage,
      time_slot: time_slot,
      image_url: "https://example.com/#{band.downcase.gsub(' ', '_')}.jpg"
    }
  end
end

Show.create!(shows)
puts "Created #{shows.count} shows"

users.each do |user|
  favorite_shows = Show.all.sample(3)
  favorite_shows.each do |show|
    UsersShow.create!(user: user, show: show, favorited: true)
  end
end
puts "Assigned favorite shows to users"




