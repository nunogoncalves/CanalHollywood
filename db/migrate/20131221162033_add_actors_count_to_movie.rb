class AddActorsCountToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :actors_count, :integer
  end
end