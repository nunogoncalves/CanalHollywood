require 'rubygems'
require 'nokogiri'
require 'open-uri'

class Html::ParseScheduleOfDay

	attr_accessor :date, :movies, :dates, :report_start

	CANAL_HOLLYWOOD_URL = 'http://canalhollywood.pt/programacion/'

	def initialize(date)
		@date = date
		@movies = []
		@dates = []
	end

	def run
		start_report

		inner_process
		# movies.each { |m| p m.to_s }
		end_report

		self
	end

	private # ========================================== private methods

	def start_report
		@report_start = DateTime.now
		p "###############################################################################"
		p "############################ Processing #{date} ############################"
	end

	def inner_process
		document = get_html_page_document
    find_main_movie_div(document).each do |div|
      if (div['id'] == 'parrilla_registro')
      	movie = build_movie_from_div_fields(div)
        @movies << movie
        @dates << build_date_from_div(find_begin_hour_in_div(div))
      end
    end
	end

	def end_report
		p "######################### Took #{DateTime.now.to_i - report_start.to_i} seconds to fetch day #########################"
		p "###############################################################################"
		p ""
	end

	def get_html_page_document
		Nokogiri::HTML(open("#{CANAL_HOLLYWOOD_URL}#{date.to_s}/"))
	end

	def find_main_movie_div(document)
    # Search for nodes by xpath
		document.xpath('//div/div/div/div/div/div/div/div')
	end

	def build_movie_from_div_fields(div)
		Movie.new(
			{
				original_name: find_original_name_in_div(div),
	    	local_name: find_local_name_in_div(div),
	    	genre: find_genre_in_div(div),
	    	small_image_url: find_img_in_div(div),
	    	canal_hollywood_url: find_url_in_div(div),
	    	channel_id: 0
    	},
    	without_protection: true)
	end

	def build_date_from_div(begin_hour)
		_date = DateTime.strptime("#{date.to_s} #{begin_hour}", '%Y-%m-%d %H:%M')
		if _date.hour >= 0 && _date.hour < 6
			_date = _date + 1.days
		end
		_date
	end

	def find_genre_in_div(div)
		genre = div.children[1].to_s.strip
		genre = genre.match(/ - (.*)-->/m).to_s
		genre.slice! " - "
		genre.slice! "-->"
		genre
	end

	def find_original_name_in_div(div)
		original_name = div.children[5].to_s.strip
		original_name = original_name.match(/ Original: (.*)-->/).to_s
		original_name.slice! ' Original: '
		original_name.slice! "-->"
		original_name
	end

	def find_local_name_in_div(div)
		local = div.children[5].content
		local.slice!("\n        ")
		local
	end

	def find_url_in_div(div)
		div.children[3].children[0]['href']
	end

  def find_img_in_div(div)
  	div.children[3].children[0].children[0]['src']
 	end

 	def find_begin_hour_in_div(div)
 		div.children[1].content
 	end

end