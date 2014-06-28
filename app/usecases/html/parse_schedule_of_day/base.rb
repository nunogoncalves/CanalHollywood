module Html
  module ParseScheduleOfDay
    class Base < UseCase::Base
      depends GetHtmlForDay, BuildMoviesFromHtmlDocument
    end
  end
end
