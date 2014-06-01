class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale

  def set_locale
    I18n.locale = "pt"
  end

  def html_tests
    render 'layouts/html_tests'
  end

  def home
  	if params[:date].present?
  		date = DateTime.parse(params[:date]).change(hour: 6)
  	else
      date = DateTime.now
    end

    @current_date = date
  	@day_schedule = Schedule.schedules_of_day(date)

  	respond_to do |format|
        format.html { render "layouts/home"}
    end
  end
end
