class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.integer :id
      t.integer :channel_id
      t.string :original_name
      t.string :local_name
      t.integer :year
      t.string :director
      t.text :description
      t.string :genre
      t.string :big_image_url
      t.string :small_image_url
      t.integer :schedules_count, default: 0
      t.string :canal_hollywood_url

      t.datetime :canal_hollywood_premiere

      t.timestamps
    end
  end
end
