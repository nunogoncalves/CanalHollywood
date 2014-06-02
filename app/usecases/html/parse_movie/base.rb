module Html
  module ParseMovie
    class Base < UseCase::Base
      depends GetHtmlForMovie, InflateMovie
    end
  end
end
