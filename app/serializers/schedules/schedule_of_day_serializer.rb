class Schedules::ScheduleOfDaySerializer < ActiveModel::Serializer
  # attributes :channel_id, :count, :description, 
    # :director, :duration, :genre, :image_big_blob, :image_big_url, :image_small_blob, 
    # :image_small_url, :is_favourite, :is_watch_list, :youtube_url,
    # :local_name, :original_name, :rating, :year, :url, :start_date
    attributes :movies

    def movies
    	{movies: self.object.map{ |schedule| Movies::MovieSerializer.new(schedule.movie, schedule)}}
    end
end