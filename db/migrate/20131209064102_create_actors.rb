class CreateActors < ActiveRecord::Migration
  def change
    create_table :actors do |t|
      t.integer :id
      t.string :name 
      t.datetime :birth_date
      t.boolean :deceased
      t.datetime :date_of_death
      t.integer :movies_count
      t.integer :aged
      t.string :image 
      t.string :imdb_url

      t.timestamps
    end
  end
end
