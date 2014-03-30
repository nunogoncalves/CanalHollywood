class Movies::MovieSerializer < ActiveModel::Serializer
  # attributes :channel_id, :count, :description, 
    # :director, :duration, :genre, :image_big_blob, :image_big_url, :image_small_blob, 
    # :image_small_url, :is_favourite, :is_watch_list, :youtube_url,
    # :local_name, :original_name, :rating, :year, :url, :start_date


  # attributes :id, :description, :genre, :image_small_url, :image_big_url, :youtube_url, :imdb_url,
  #   :local_name, :original_name, :rating, :director, :year, :start_time, :end_time, :actors

  attributes :id, :description, :director, :year, :genre, :local_name, :original_name, :youtube_url,
    :image_small_url, :image_big_url, :imdb_url, :start_time, :start_time_date, :end_time, :end_time_date;

  def initialize(object, schedule)
    super(object)
    @schedule = schedule
  end


  # has_many :actors

  def actors
    self.object.actors
  end

  def image_small_url
    return self.object.small_image_url if self.object.small_image_url.present?
    return "http://multicanaltv.com/images/hollywoodpt/sinimagen_th.jpg"
  end

  def image_big_url
    return self.object.big_image_url if self.object.big_image_url.present?
    return "http://multicanaltv.com/images/hollywoodpt/sinimagen_th.jpg"
  end

  def youtube_url
    self.object.youtube_full_url
  end

  def start_time_date
    @schedule.start_date_time.strftime("%Y-%m-%d")
  end

  def start_time
    @schedule.start_date_time.strftime("%Y-%m-%d %H:%M")
  end

  def end_time_date
    @schedule.end_date_time.strftime("%Y-%m-%d")
  end

  def end_time
    @schedule.end_date_time.strftime("%Y-%m-%d %H:%M")
  end

end