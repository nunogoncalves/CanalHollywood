module Html
  module ParseMovie
    class Base < UseCase::Base
      depends GetHtmlForMovie, Movies::UpdateFromDetailsHtml
    end
  end
end
