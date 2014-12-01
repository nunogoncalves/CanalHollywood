module SyncWithCanalHollywood
  class SaveSchedules < UseCase::Base

    def perform
      movies = context.movies
      dates = context.dates

      movies.each_with_index do |movie, i|
        begin_date = dates[i]
        end_date = i == (movies.count - 1) ? begin_date + 120.minutes : dates[i+1]

        if movie_aready_exists?(movie)
          existing_movie = Movie.find_by_canal_hollywood_url(movie.canal_hollywood_url)
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

      # end_time = i == (@movies_list.count - 1) ? @begin_dates[i] + 120.minutes : @begin_dates[i+1]
      # schedule = movie.schedules.new({start_date_time: @begin_dates[i], end_date_time: end_time, duration_mins: (end_time.to_i - @begin_dates[i].to_i) / 60 }, without_protection: true)
      # movie.canal_hollywood_premiere = @begin_dates[i] if movie.canal_hollywood_premiere.nil? || movie.canal_hollywood_premiere > @begin_dates[i]
      # if movie.canal_hollywood_premiere.blank? || schedule.start_date_time < movie.canal_hollywood_premiere
      #   movie.canal_hollywood_premiere = schedule.start_date_time
      # end
      # movie.save

    end

    def movie_aready_exists?(movie)
      Movie.where(canal_hollywood_url: movie.canal_hollywood_url).count > 0
    end

  end
end
