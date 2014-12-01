module SyncWithCanalHollywood
  class GetSchedulesOfDates < UseCase::Base

    def perform
      context.date_range.days_of_range.each do |day|
        context.day = day
        print_header_for_day(day)
        day_parser = parse_day_schedule
        context.movies = day_parser.movies
        context.dates = day_parser.dates
      end
    end

    def print_header_for_day(day)
      Printers::PrintMessagesPaddedWithSymbol.perform(
        messages: ["Getting schedules of day #{day}"],
        color: 'yellow')
    end

    def parse_day_schedule
      Html::ParseScheduleOfDay::Base.perform(context)
    end

  end
end
