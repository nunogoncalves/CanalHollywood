class Movies::Search

	attr_accessor :params, :q, :query

	NO_PARAMS = {
		"no_imdb" => "no_imdb",
		"no_youtube" => "no_youtube",
		"no_director" => "no_director",
		"no_actors" => "no_actors",
		"genre" => "genre"
	}

	def initialize(params)
		@params = params
		@page = params[:page] || 1
		@query = params[:query]
		@q = params[:q]
		@order = params[:order] || "id desc"
	end

	def run!
		if NO_PARAMS[@query].blank?
			@search = Movie.order(@order).page(@page).per(50).search(@q)
			@movies = search.result
		else
			@movies = send("#{NO_PARAMS[@query]}").result
		end

		self
	end

	def movies
		@search.result
	end

	def search
		@search
	end

	def order
		@order
	end

	private # -------------------------------------------------------------private methods

	def no_imdb
		@search = Movie.where("imdb_url is null or imdb_url = ''").order(@order).page(@page).per(50).search(@q)
	end
	
	def no_youtube
		@search = Movie.where("youtube_url is null or youtube_url = ''").order(@order).page(@page).per(50).search(@q)
	end

	def no_director
		@search = Movie.where("director is null or director = ''").order(@order).page(@page).per(50).search(@q)
	end

	def no_actors
		all_casts = Cast.pluck(:movie_id).uniq
		@search = Movie.where("id not in (?)", all_casts).order(@order).page(@page).per(50).search(@q)
	end

	def genre
		@genre = @query
		@search = Movie.where(genre: params[:genre]).order(@order).page(@page).per(50).search(@q)
	end

end