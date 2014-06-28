class MoviesController < ApplicationController

	def index
		@title = "listagem"
		@searcher = Movies::Search.new(params).run!

		respond_to do |format|
			format.html
			format.js
		end
	end

	def all_of_month
		set_date
		begin_date = @date.at_beginning_of_month.change(hour: 6, min: 0)
    end_date = begin_date.next_month
		@movies_ids = Schedule.where("start_date_time > ? AND end_date_time < ?", begin_date, end_date).order("movie_id asc").pluck(:movie_id).uniq
	end

	def last_seven_days
		@movies = []
		schedules = Schedule.where(start_date_time: 7.days.ago..DateTime.now).uniq.order("start_date_time desc")
		schedules.each do |s|
			@movies << s.movie
		end
	end

	def show
		@movie = Movie.find(params[:id])
		@title = @movie.original_name
	end

	def edit
		@movie = Movie.find(params[:id])
		@title = "#{@movie.original_name} - Editar"
	end

	def update
		@movie = Movie.find(params[:id]);
		@movie.update_attributes(params[:movie])
		render :edit
	end

	def sync
		SyncWithCanalHollywood::Base.perform
		# Movies::SyncWithHollywoodx.new.run
		render nothing: true
	end

	def imdb_rating
		Movie.find(params[:id]).update_attribute("imdb_rating", params[:rating])
		render nothing: true
	end

	def refresh
		movie = Movie.find(params[:id])
		if movie.present?
			movie = Html::ParseMovie.new(movie).run.movie
			movie.save!
			render json: {description: movie.description, image: movie.small_image_url}
		else
			render json: {idescription: movie.description, image: ""}
		end
	end


	def set_date
    if params[:date].present?
      @date = DateTime.parse(params[:date])
    else
      @date = DateTime.now
    end
  end

end