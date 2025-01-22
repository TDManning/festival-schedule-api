class RemoveFavoritedFromUsersShows < ActiveRecord::Migration[7.1]
  def change
    remove_column :users_shows, :favorited, :boolean
  end
end
