module SyncWithCanalHollywood
  class GetSchedulesOfDates < UseCase::Base

    def perform
      context.date_range.days_of_range.each do |day|
        context.day = day
        Printers::PrintMessagesPaddedWithSymbol.perform(messages: ["Getting schedules of day #{day}"])
        day_parser = Html::ParseDay::Base.perform(context)
        context.movies = day_parser.movies
        context.dates = day_parser.dates
      end
    end

  end
end
