require 'rubygems'
require 'nokogiri'
require 'open-uri'

class Html::ParseMovie

	CANAL_HOLLYWOOD_URL = 'http://canalhollywood.pt/'

	attr_accessor :movie, :doc, :report_start

	def initialize(movie, debug = true)
		@movie = movie
		@debug = debug
	end

	def run
		@report_start = DateTime.now
		_print "######################## Parsing #{movie.original_name} ########################"

		@doc = get_html_page_document
		inflate_movie
		report_end
		self
	end

	private # ============================================= private ============

	def get_html_page_document
		Nokogiri::HTML(open("#{CANAL_HOLLYWOOD_URL}#{@movie.canal_hollywood_url}"))
	end

	def inflate_movie
		@movie.description = fetch_description
    @movie.year = fetch_year
    @movie.director = fetch_director
    @movie.big_image_url = fetch_big_image_url
    @movie.small_image_url = fetch_small_image_url
	end

	def fetch_description
		doc.xpath('//div[@id="texto_principal_"]').first.content.to_s
	end

	def fetch_year
		year = doc.xpath('//h1[@id="texto_titulo_"]').first.content
		year = year.slice!(year.length-5..year.length-2)
		year.to_i
	end

	def fetch_director
		director = doc.xpath('//div[@id="texto_datos_"]').to_s

		director = director.match(/Diretor:(.*).<br>/m).to_s
		director.slice! "\n                \n                <br>"
		director.slice! "Diretor:<\/strong> "
		director.slice! ".<br>"
    director
	end

	def fetch_big_image_url
		doc.xpath('//img[@id="img_fichaprog"]/@src').to_s
	end

	def fetch_small_image_url
		movie.big_image_url.sub!('hollywoodpt/prg/', 'hollywoodpt/prg/th/')
	end

	def report_end
		_print "######################### Took #{DateTime.now.to_i - report_start.to_i} seconds to fetch movie #########################"
		_print "###############################################################################"
	end

	def _print(message)
		p message if @debug
	end
end