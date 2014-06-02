module Html
  module ParseDay
    class Base < UseCase::Base
      depends GetHtmlForDay, BuildMoviesFromHtmlDocument
    end
  end
end
