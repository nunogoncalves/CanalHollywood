class SchedulesController < ApplicationController

  before_filter :set_date

	def index
    @date = @date.change(hour: 6)
    @current_date = @date
    @day_schedule = Schedule.schedules_of_day(@date)
    @search = Movie.where("movies.id IS NOT NULL").page(params[:page]).per(50).search(params[:q])

    respond_to do |format|
      format.html
      format.js
      format.json {
        render json: Schedules::ScheduleOfDaySerializer.new(@day_schedule).movies
      }
    end
  end

  def premieres_of_month
    begin_date = @date.at_beginning_of_month.change(hour: 6, min: 0)
    end_date = begin_date.next_month
    @movies = Movie.where("canal_hollywood_premiere > ? AND canal_hollywood_premiere < ?", begin_date, end_date).order("canal_hollywood_premiere asc")
  end

  def premieres_of_day

  end

  def premieres_of_year

  end

  def edit_day_schedule
    @movies = []
  end

  def update_day_schedule
    @item_id = params["item_id"]
    begin
      raise "movie is nil" if params["movie_id"].blank?
      start_date_time = DateTime.strptime("#{params['start_date']} #{params['start_time']}", '%d/%m/%Y %H:%M')
      end_date_time = DateTime.strptime("#{params['end_date']} #{params['end_time']}", '%d/%m/%Y %H:%M')
      movie_id = params["movie_id"]
      @schedule = Schedule.new(start_date_time: start_date_time, end_date_time: end_date_time, movie_id: movie_id, duration_mins: (end_date_time.to_i - start_date_time.to_i) / 60)
      @schedule.save
    rescue => e
      @error = e
    end

    respond_to do |format|
      format.js
    end
  end

  private

  def set_date
    if params[:date].present?
      @date = DateTime.parse(params[:date])
    else
      @date = DateTime.now
    end
  end

end