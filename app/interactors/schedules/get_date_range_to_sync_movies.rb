class Schedules::GetDateRangeToSyncMovies

	attr_accessor :date_range

	def initialize
		run		
	end

	def run
		begin_date = get_last_date_on_db

    end_date = begin_date.change(day: 1)
    end_date = end_date + 1.months - 1.days
    DateRange.new(begin_date, end_date)
	end

	private # --------------------------- private methods

	def get_last_date_on_db
		last_schedule = Schedule.order("schedules.end_date_time DESC").first
		return Date.new(2013, 7, 31) if last_schedule.nil?

		begin_date = last_schedule.end_date_time.to_date
    begin_date = begin_date.change(hour: 0, min: 0)

    begin_date
	end

end