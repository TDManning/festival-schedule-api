class CreateUsersShows < ActiveRecord::Migration[7.1]
  def change
    create_table :users_shows do |t|
      t.references :user, null: false, foreign_key: true
      t.references :show, null: false, foreign_key: true
      t.boolean :favorited, default: false 

      t.timestamps
    end

    add_index :users_shows, [:user_id, :show_id], unique: true
  end
end
