class Show < ApplicationRecord
  has_many :users_shows, dependent: :destroy
  has_many :users, through: :users_shows

  validates :artist, :location, :time_slot, presence: true
  validates :time_slot, numericality: { only_integer: true }
end
