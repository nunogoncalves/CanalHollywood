class StatisticsController < ApplicationController

	def index
		@statistics_presenter = Statistics::IndexPresenter.new(view_context, nil)
	end

	def movies_of_year
		return index if params[:year].blank?
		@year = params[:year]
		@movies = Movie.where(year: @year)
	end

end