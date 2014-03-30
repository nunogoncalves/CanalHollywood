class AddCanalHollywoodMovieIdToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :canal_hollywood_id, :string
  end
end
