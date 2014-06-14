module SyncWithCanalHollywood
  class GetMoviesFullInformation < UseCase::Base

    def perform
      context.movies.each_with_index do |movie, i|
        if not_exists?(movie)
          messages = "#{i}: Fetching #{movie.canal_hollywood_url} full info"
          Printers::PrintMessagesPaddedWithSymbol.perform(messages: [messages])
          Html::ParseMovie::Base.perform(movie: movie)
        else
          messages = "#{i}: Exists"
          Printers::PrintMessagesPaddedWithSymbol.perform(messages: [messages])
        end
      end
    end

    private # ============ private methods ===================

    def not_exists?(movie)
      Movie.find_by_canal_hollywood_url(movie.canal_hollywood_url).present?
    end

  end
end
