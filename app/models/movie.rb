#encoding UTF-8
class Movie < ActiveRecord::Base
  attr_accessible :id, :big_image_url, :canal_hollywood_url, 
  :schedules_count, :description, :director, :genre, :actor_ids,
  :local_name, :original_name, :small_image_url, :year, :channel_id, :imdb_url, :youtube_url

  has_many :schedules
  has_many :casts
  has_many :actors, through: :casts

  validate :youtube_url, :url => false

  after_save :update_actors_count

  def exists?
    Movie.where(canal_hollywood_url: self.canal_hollywood_url).count > 0
  end

  def small_image_display
    if small_image_url.present? && small_image_url != "http://multicanaltv.com/images/hollywoodpt/sinimagen_th.jpg"
      return small_image_url
    else
      "/assets/no_image.jpg"
    end
  end

  def big_image_display
    if big_image_url.present? && big_image_url != "http://multicanaltv.com/images/hollywoodpt/sinimagen_th.jpg"
      return big_image_url
    else
      "/assets/no_image.jpg"
    end
  end

  def contains_all_information?
  	description.present? && small_image_url.present? && director.present?
  end

  def missing_information?
    !contains_all_information?
  end

  def original_name_no_spaces
    original_name.sub(" ", "+")
  end

  def youtube_full_url
    return nil if youtube_url.blank?
    return youtube_url if youtube_url_complete?
    "https://www.youtube.com/watch?v=#{youtube_url}"
  end

  def youtube_for_container
    return nil if youtube_url.blank?
    return youtube_url.slice(32..youtube_url.length) if youtube_url.include?("http")
    return youtube_url
  end

  def premiere_mini_formatted
    I18n.l(canal_hollywood_premiere, format: "%a, %Y-%m-%d %H:%M")
  end
  
  def premiere_formatted
    I18n.l(canal_hollywood_premiere, format: "%A, %d de %B de %Y, as %H:%M")
  end

  def youtube_url_complete?
    youtube_url.include?("https://www.youtube.com/watch?")
  end

  def next_movie
    @next_movie ||= Movie.where("id > #{self.id}").order("id asc").limit(1).first || Movie.order("id asc").limit(1).first
  end

  def next_movie_id
    next_movie.id
  end

  def previous_movie
    @previous_movie ||= Movie.where("id < #{self.id}").order("id desc").limit(1).first || Movie.order("id desc").limit(1).first
  end

  def previous_movie_id
    previous_movie.id
  end

  def search_youtube_url
    "https://www.youtube.com/results?search_query=#{original_name_no_spaces}+trailer&oq=#{original_name_no_spaces}+trailer&gs_l=youtube.12...0.0.0.5687021.0.0.0.0.0.0.0.0..0.0...0.0...1ac..11.youtube."
  end

  def search_imdb_url
    "http://www.imdb.com/find?s=all&q=#{original_name_no_spaces}"
  end

  def imdb_full_url
    "http://www.imdb.com/title/#{imdb_url}/"
  end

  def update_actors_count
    update_column("actors_count", self.actors.count)
  end

  def has_future_schedule?
    schedules.where("start_date_time > '#{DateTime.now}'").count > 0
  end

  def self.update_all_movies_full_information
    count = Movie.all.count;
    Movie.order(:id).each_with_index do |m, i|
      p "#{i} (Missing: #{count - i}): Updating movie #{m.id}#{m.original_name}"
      Html::ParseMovie.new(m, false).run.movie.save
    end
    p "---------------------------------------------------------->>>>> Finished!"
  end

  def self.update_movie_actors
    Movie.all.each do |movie|
      movie.update_actors_count
    end
  end

  def self.update_premiere
    Movie.all.each do |movie|
      premiere = movie.schedules.order("start_date_time asc").limit(1).first
      movie.update_attribute("canal_hollywood_premiere", premiere.start_date_time)
    end
  end

  def self.current_movie
    now = DateTime.now + 1.hours
    now_schedule = Schedule.where("start_date_time < ? AND end_date_time > ?", now, now).first
    movie = now_schedule.movie
  end

end
