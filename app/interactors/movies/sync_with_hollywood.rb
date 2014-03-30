class Movies::SyncWithHollywood

	attr_accessor :date_range, :movies_list, :bengin_dates

	def initialize
		@date_range = Schedules::GetDateRangeToSyncMovies.new.run
		@movies_list = []
		@begin_dates = []
	end

	def run
		@report_start = DateTime.now
		print_header

		process_days
		get_movies_full_information

		print_footer
	end

	private # =================================================== private methods ===============
	def print_header
		p "###############################################################################"
		p "###############################################################################"
    p "############################# - Fetching movies - #############################"
    p "##################### - FROM: #{date_range.start_date} TO: #{date_range.end_date} - #####################"
		p "###############################################################################"
		p "###############################################################################", ""
	end

	def print_footer
		p "", "###############################################################################"
		p "###############################################################################"
		p "##################### - FROM: #{date_range.start_date} TO: #{date_range.end_date} - #####################"
    p "############################# - Took #{DateTime.now.to_i - @report_start.to_i} seconds - #############################"
		p "###############################################################################"
	end

	def process_days
		date_range.days_of_range.each do |day|
			if !Schedule.day_contains_movies?(day)
				process_day(day)
			else
				p "##################### - Day #{day} contains movies - ######################"
			end
		end
	end

	def process_day(day)
		day_processer = Html::ParseScheduleOfDay.new(day).run
		movies = day_processer.movies
		begin_times = day_processer.dates

		@movies_list = @movies_list + movies
		@begin_dates = @begin_dates + begin_times
	end

	def get_movies_full_information
		length = @movies_list.count
		@movies_list.each_with_index do |movie, i|
			if movie.exists?
				movie = Movie.find_by_canal_hollywood_url(movie.canal_hollywood_url)
			else
				p "############ #{i+1}/#{length} -> Checking movie #{movie.to_s} ############"
				Movies::FetchMovieCompleteInformation.new(movie).run
			end
			end_time = i == (@movies_list.count - 1) ? @begin_dates[i] + 120.minutes : @begin_dates[i+1]
			schedule = movie.schedules.new({start_date_time: @begin_dates[i], end_date_time: end_time, duration_mins: (end_time.to_i - @begin_dates[i].to_i) / 60 }, without_protection: true)
			movie.canal_hollywood_premiere = @begin_dates[i] if movie.canal_hollywood_premiere.nil? || movie.canal_hollywood_premiere > @begin_dates[i]
			if movie.canal_hollywood_premiere.blank? || schedule.start_date_time < movie.canal_hollywood_premiere
				movie.canal_hollywood_premiere = schedule.start_date_time
			end
			movie.save
		end
	end

end