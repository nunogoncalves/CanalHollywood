class AddCanalHollywoodMovieIdToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :canal_hollywood_id, :string
    add_column :movies, :imdb_url, :string
    add_column :movies, :youtube_url, :string
  end
end
