class CreateCast < ActiveRecord::Migration
  def change
    create_table :casts do |t|
      t.integer :id
      t.integer :actor_id
      t.integer :movie_id

      t.timestamps
    end
  end
end
