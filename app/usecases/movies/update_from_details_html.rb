module Movies
  class UpdateFromDetailsHtml < UseCase::Base

    attr_accessor :movie, :document

    def perform
      @movie = context.movie
      @document = context.document

      inflate_movie
    end

    private #-------------------------- private methods ---------------------

    def inflate_movie
      movie.description = extract_description
      movie.year = extract_year
      movie.director = extract_director
      movie.big_image_url = extract_big_image_url
      movie.small_image_url = extract_small_image_url
    end

    def extract_description
      document.xpath('//div[@id="texto_principal_"]').first.content.to_s
    end

    def extract_year
      year_content = document.xpath('//h1[@id="texto_titulo_"]').first.content
      year_txt = year_content.slice!(year_content.length-5..year_content.length-2)
      year_txt.to_i
    end

    def extract_director
      director = document.xpath('//div[@id="texto_datos_"]').to_s

      director = director.match(/Diretor:(.*).<br>/m).to_s
      director.slice! "\n                \n                <br>"
      director.slice! "Diretor:<\/strong> "
      director.slice! ".<br>"
      director
    end

    def extract_big_image_url
      document.xpath('//img[@id="img_fichaprog"]/@src').to_s
    end

    def extract_small_image_url
      movie.big_image_url.sub('hollywoodpt/prg/', 'hollywoodpt/prg/th/')
    end
  end
end