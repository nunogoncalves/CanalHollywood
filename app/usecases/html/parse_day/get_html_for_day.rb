module Html
  module ParseDay
    class GetHtmlForDay < UseCase::Base

      CANAL_HOLLYWOOD_URL = 'http://canalhollywood.pt/programacion/'

      def perform
        day = context.day.to_s
        context.document = Html::GetHtmlDocumentForUrl.perform(url: "#{CANAL_HOLLYWOOD_URL}#{day}/").document
      end

    end
  end
end