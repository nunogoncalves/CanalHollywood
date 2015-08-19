class Schedule < ActiveRecord::Base
  attr_accessible :duration_mins, :end_date_time, :movie_id, :start_date_time, :duration

  belongs_to :movie, :counter_cache => true

  def self.schedules_of_day(date = DateTime.now)
    date = date - 1.days if date.hour < 6
    start_time = date.change(hour: 6, min: 0)
    end_time = (start_time + 1.days).change(hour: 5, min: 59)
    Schedule.where("start_date_time >= '#{start_time}' and start_date_time < '#{end_time}'").includes(:movie).order(:start_date_time)
  end

  def self.day_contains_movies?(date)
  	begin_day = date.change(hour: 6, min: 59)
    end_day = date + 1.days
  	where(start_date_time: begin_day..end_day).count > 5
  end

  def formatted_date
    "#{start_date_time.strftime('%Y-%m-%d')}"
  end

  def premiere_format
    "#{start_date_time.strftime("%Y/%m/%d - %H:%M")}"
  end

  def display_date_time
    I18n.l(start_date_time, format: "%A, %d de %B de %Y, as %H:%M")
  end

  def start_and_end_hours
    "#{start_date_time.strftime("%H:%M")} - #{end_date_time.strftime("%H:%M")}"
  end

  def is_currently_on_air?
    now = DateTime.now
    start_date_time < now &&  now < end_date_time
  end

  def is_future?
    start_date_time > DateTime.now
  end

  def current_percentage
    now = DateTime.now
    ((now.to_i - start_date_time.to_i).to_f / (end_date_time.to_i - start_date_time.to_i).to_f * 100).round(2)
  end

  def to_s
    "start_date_time: #{start_date_time}, end_date_time: #{end_date_time}, movie: #{movie.original_name}, duration_mins: #{duration_mins}"
  end
end
