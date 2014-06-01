class Movies::FetchMovieCompleteInformation

	attr_accessor :movie

	def initialize(movie)
		@movie = movie
	end

	def run
		if @movie.contains_all_information?
			p " Already filled"
			return self
		else
			movie = Html::ParseMovie.new(@movie).run.movie
		  return self
		end
	end


end