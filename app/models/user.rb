class User < ApplicationRecord
  has_many :users_shows, dependent: :destroy
  has_many :shows, through: :users_shows

  validates :username, :first_name, :last_name, presence: true
end
