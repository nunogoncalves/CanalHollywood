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

  private

  def set_date
    if params[:date].present?
      @date = DateTime.parse(params[:date])
    else
      @date = DateTime.now
    end
  end

end