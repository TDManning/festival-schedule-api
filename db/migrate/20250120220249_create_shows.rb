class CreateShows < ActiveRecord::Migration[7.1]
  def change
    create_table :shows do |t|
      t.string :artist, null: false
      t.string :location, null: false
      t.integer :time_slot
      t.string :image_url

      t.timestamps
    end
  end
end
