module SyncWithCanalHollywood
  class SaveSchedules < UseCase::Base

    def perform
      movies = context.movies
      dates = context.dates

      movies.each_with_index do |movie, i|
        begin_date = dates[i]
        end_date = i == (movies.count - 1) ? begin_date + 120.minutes : dates[i+1]

        if movie_aready_exists?(movie) || Movie.where_canal_hollywood_url_or_original_name(movie.canal_hollywood_url, movie.original_name).present?
          existing_movie = Movie.where_canal_hollywood_url_or_original_name(movie.canal_hollywood_url, movie.original_name).first
          existing_movie.schedules_count = existing_movie.schedules_count.present? ? existing_movie.schedules_count+1 : 1

          existing_movie.schedules.new({start_date_time: begin_date, end_date_time: end_date, duration_mins: (end_date.to_i - begin_date.to_i) / 60 }, without_protection: true)
          existing_movie.save

        else
          new_schedule = movie.schedules.new({start_date_time: begin_date, end_date_time: end_date, duration_mins: (end_date.to_i - begin_date.to_i) / 60 }, without_protection: true)
          if movie.canal_hollywood_premiere.blank? || new_schedule.start_date_time < movie.canal_hollywood_premiere
            movie.canal_hollywood_premiere = new_schedule.start_date_time
          end
          movie.save
        end
        puts "#{i}:".pink + " #{movie.original_name} - #{dates[i]}"
      end

    end

    def movie_aready_exists?(movie)
      movie.exists?
      # Movie.where(canal_hollywood_url: movie.canal_hollywood_url).count > 0
    end

  end
end
