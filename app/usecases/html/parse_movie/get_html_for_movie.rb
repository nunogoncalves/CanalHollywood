module Html
  module ParseMovie
    class GetHtmlForMovie < UseCase::Base

      def perform
        url = "#{CANAL_HOLLYWOOD_BASE_URL}#{context.movie.canal_hollywood_url}"
        context.document = Html::GetHtmlDocumentForUrl.perform(url: url).document
      end

    end
  end
end
