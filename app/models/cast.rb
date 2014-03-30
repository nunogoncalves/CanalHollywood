class Cast < ActiveRecord::Base
  attr_accessible :actor_id, :movie_id

  belongs_to :actor
  belongs_to :movie

  after_create :update_actor_movies, :update_movie_actors

  def update_actor_movies
  	count = Cast.where(actor_id: actor_id).count
  	self.actor.update_attribute("movies_count", count)
  	self.save!
  end

  def update_movie_actors
  	count = Cast.where(movie_id: movie_id).count
  	self.movie.update_attribute("actors_count", count)
  	self.save!
  end
end
