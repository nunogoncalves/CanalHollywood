class Statistics::IndexPresenter < Presenter


	def total_movies
		@total_movies ||= Movie.all.count
	end

	def movies_with_actors
		Cast.pluck(:movie_id).uniq.count
	end

	def movie_with_most_actors
		movie = Movie.order("actors_count desc").limit(1).first
		link = h.link_to "#{movie.original_name}", h.movie_path(movie.id), {target: "_blank"}
		"#{link} - #{movie.actors_count}"
	end

	def oldest_movie
		oldest = _oldest_movie
		link = h.link_to "#{oldest.original_name}", h.movie_path(oldest.id)
		"#{link} - #{oldest.year}"
	end

	def newest_movie
		newest = _newest_movie
		link = h.link_to "#{newest.original_name}", h.movie_path(newest.id)
		"#{link} - #{newest.year}"
	end

	def average_month_premieres
		first_date = Movie.order(:id).first.canal_hollywood_premiere
		last_date = Movie.order(:id).last.canal_hollywood_premiere
		months_between = (last_date.year * 12 + last_date.month) - (first_date.year * 12 + first_date.month)
		total_movies / months_between
	end

	def total_actors
		@total_actors = Actor.all.count
	end

	def actor_with_most_movies
		actor = Actor.order("movies_count desc").limit(1).first
		link = h.link_to "#{actor.name}", h.actor_path(actor.id), {target: "_blank"}
		"#{link} - #{actor.movies_count}"
	end

	def actors_with_no_photo
		Actor.where("image = '' or image IS NULL").count
	end

	def actors_with_no_imdb
		Actor.where("imdb_url = '' or imdb_url IS NULL").count
	end

	def actors_no_age
		@actors_no_age ||= Actor.where("birth_date is null").count
	end

	def oldest_actor
		actor = Actor.order("birth_date asc").limit(1).first
		link = h.link_to "#{actor.name} (#{actor.display_age})", h.edit_actor_path(actor.id)
	end

	def deceased_actors
		Actor.where(deceased: true).count
	end

	def _oldest_movie
		@oldest_movie ||= Movie.where("id != 237").order("year asc").limit(1).first
	end

	def _newest_movie
		@newest_movie ||= Movie.where("id != 237").order("year desc").limit(1).first
	end

	def years
		@years ||= Movie.order("year").select("year").uniq.pluck(:year)
	end

end