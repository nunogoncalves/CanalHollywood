module SyncWithCanalHollywood
  class GetMoviesFullInformation < UseCase::Base

    def perform
      not_saved_but_fetched_list = []
      total = context.movies.count
      context.movies.each_with_index do |movie, i|
        if exists?(movie) || not_saved_but_fetched_list.include?(movie.canal_hollywood_url)
          messages = "#{i}/#{total}: Exists"
          Printers::PrintMessagesPaddedWithSymbol.perform(messages: [messages], color: 'red')
        else
          messages = "#{i}/#{total}: Fetching #{movie.canal_hollywood_url} full info"
          Printers::PrintMessagesPaddedWithSymbol.perform(messages: [messages], color: 'green')
          Html::ParseMovie::Base.perform(movie: movie)
          not_saved_but_fetched_list << movie.canal_hollywood_url
        end
      end
    end

    private # ============ private methods ===================

    def exists?(movie)
      Movie.find_by_canal_hollywood_url(movie.canal_hollywood_url).present?
    end

  end
end
