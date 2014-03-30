class	Movies::TopBarPresenter

	def total
		@total = Movie.all.count
	end

	def imdb_total
		@imdb_total ||= Movie.where("imdb_url is not null and imdb_url != ''").count
	end

	def imdb_percentage
		@imdb_percentage ||= calculate_percentage(imdb_total)
	end

	def imdb_text
		"#{imdb_total} / #{total} (#{imdb_percentage}%)"
	end

	def youtube_total
		@youtube_total ||= Movie.where("youtube_url is not null and youtube_url != ''").count
	end

	def youtube_percentage
		@youtube_percentage ||= calculate_percentage(youtube_total)
	end

	def youtube_text
		"#{youtube_total} / #{total} (#{youtube_percentage}%)"
	end

	def with_actors_total
		@with_actors_total ||= Cast.pluck(:movie_id).uniq.count
	end

	def with_actors_text
		"#{with_actors_total} / #{total} (#{with_actors_percentage}%)"
	end

	def with_actors_percentage
		@with_actors_percentage ||= calculate_percentage(with_actors_total)
	end

	def directed_total
		@directed_total ||= Movie.where("director is not null and director != ''").count
	end
	
	def directed_percentage
		@directed_percentage ||= calculate_percentage(with_actors_total)
	end

	def directed_text
		"#{directed_total} / #{total} (#{directed_percentage}%)"
	end

	def genres
		@genres ||= Movie.pluck(:genre).uniq
	end

	def genres_select2_label
		lambda{ |obj| "#{obj} - #{Movie.where(genre: obj).count}"}
	end

private # ------------------------------------------ private 

	def calculate_percentage(total_scoped)
		((total_scoped.to_f / @total.to_f) * 100).round(2)
	end

end