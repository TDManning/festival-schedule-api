class Show < ApplicationRecord
  has_many :users_shows, dependent: :destroy
  has_many :users, through: :users_shows

  validates :artist, :location, presence: true
end
