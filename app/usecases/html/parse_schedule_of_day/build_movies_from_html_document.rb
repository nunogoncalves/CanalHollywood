#encoding: utf-8
module Html
  module ParseScheduleOfDay

    class BuildMoviesFromHtmlDocument < UseCase::Base

      attr_accessor :movies, :dates, :date

      def perform
        @date = context.day

        @movies = movies_or_new_array
        @dates = dates_or_new_array

        schedule_html_elements.each do |schedule_html_element|
          movie = build_movie_from_schedule_element(schedule_html_element)
          str = "      \\\-- #{movie.original_name}".ljust(45)
          Printers::PrintSimpleMessages.perform(messages: [str])
          movies << movie
          dates << build_date_from_html_element(extract_begin_hour(schedule_html_element))
        end
      end

      private #================= private methods

      def movies_or_new_array
        context.movies ||= []
      end

      def dates_or_new_array
        context.dates ||= []
      end

      def schedule_html_elements
        context.document.xpath('//div/div/div/div/div/div/div/div').select do |html_element|
          html_element['id'] == 'parrilla_registro'
        end
      end

      def build_movie_from_schedule_element(schedule_html_element)
        Movie.new(
          {
            original_name: extract_original_name(schedule_html_element),
            local_name: extract_local_name(schedule_html_element),
            genre: extract_genre(schedule_html_element),
            small_image_url: extract_small_image_url(schedule_html_element),
            canal_hollywood_url: extract_canal_hollywood_url(schedule_html_element),
            canal_hollywood_id: extract_canal_hollywood_id(extract_canal_hollywood_url(schedule_html_element)),
            channel_id: 0
          },
          without_protection: true)
      end

      def extract_original_name(html_element)
        #it's inside a comment...
        original_name = html_element.children[5].to_s.strip
        original_name = original_name.match(/ Original: (.*)-->/).to_s
        original_name.slice! ' Original: '
        original_name.slice! "-->"
        original_name = swap_after_comma_to_beggining(original_name, "The")
        original_name
      end

      def extract_local_name(html_element)
        local_name = html_element.children[5].text.strip
        local_name = swap_after_comma_to_beggining(local_name, "A")
        local_name = swap_after_comma_to_beggining(local_name, "O")
        local_name
      end

      def extract_genre(html_element)
        genre = html_element.children[1].to_s.strip
        genre = genre.match(/ - (.*)-->/m).to_s
        genre.slice! " - "
        genre.slice! "-->"
        genre = 'Comédia' if genre == 'Comedia'
        genre = 'Acção' if genre == 'Accao'
      end

      def extract_canal_hollywood_url(html_element)
        html_element.children[3].children[0]['href']
      end

      def extract_canal_hollywood_id(canal_hollywood_url)
        str = canal_hollywood_url
        str.slice!("/programa/")
        str = str.slice(0..(str.index('/')-1))
        str
      end

      def extract_small_image_url(html_element)
        html_element.children[3].children[0].children[0]['src']
      end

      def extract_begin_hour(html_element)
        html_element.children[1].content
      end

      def build_date_from_html_element(begin_hour)
        _date = DateTime.strptime("#{date.to_s} #{begin_hour}", '%Y-%m-%d %H:%M')
        if _date.hour >= 0 && _date.hour < 6
          _date = _date + 1.days
        end
        _date
      end

      def swap_after_comma_to_beggining(str, tail)
        ends_with_matcher = ", #{tail}"
        if str.end_with?(ends_with_matcher)
          return "#{tail} #{str[0..str.rindex(ends_with_matcher)-1]}"
        end
        str
      end
    end
  end
end
