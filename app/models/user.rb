class User < ApplicationRecord
  has_many :users_shows, dependent: :destroy
  has_many :shows, through: :users_shows

  validates :username, :first_name, :last_name, presence: true

  def self.find_with_error_handling(user_id)
    find(user_id)
  rescue ActiveRecord::RecordNotFound
    raise ActiveRecord::RecordNotFound, 'User not found'
  end

  def add_show_to_schedule(show_id, favorited = false)
    show = Show.find(show_id)
    user_show = users_shows.find_or_initialize_by(show: show)

    if user_show.persisted?
      { error: 'Show already in schedule', status: :unprocessable_entity }
    else
      user_show.favorited = favorited
      user_show.save
      { success: user_show }
    end
  rescue ActiveRecord::RecordNotFound
    { error: 'Show not found', status: :not_found }
  end
end
