module SyncWithCanalHollywood
  class CalculateDateRangeToSyncWith < UseCase::Base

    def perform
      begin_date = get_last_date_on_db_or_first_date_on_canal_hollywood_site

      end_date = begin_date.change(day: 1)
      end_date = end_date + 1.months - 1.days

      context.date_range = DateRange.new(begin_date, end_date)
    end

    private # --------------------------- private methods

    def get_last_date_on_db_or_first_date_on_canal_hollywood_site
      last_schedule = Schedule.order("schedules.end_date_time DESC").first

      if last_schedule.nil?
        return get_first_date_on_canal_hollywood_site
      else
        begin_date = last_schedule.end_date_time.to_date
        begin_date = begin_date.change(hour: 0, min: 0)
        return begin_date
      end
    end

    def get_first_date_on_canal_hollywood_site
      return Date.new(2013, 7, 27)
    end

  end
end
