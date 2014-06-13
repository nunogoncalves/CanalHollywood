module SyncWithCanalHollywood
  class GetMoviesFullInformation < UseCase::Base

    def perform
      context.movies.each do |movie|
        # messages = "Fetching #{movie.original_name} full info"
        messages = "Fetching #{movie.canal_hollywood_url} full info"
        Printers::PrintMessagesPaddedWithSymbol.perform(messages: [messages])
        Html::ParseMovie::Base.perform(movie: movie)
      end
    end

  end
end
