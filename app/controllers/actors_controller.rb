class ActorsController < ApplicationController

	def index
		@order = params[:order] || "movies_count desc"
		@page = params[:page] || 1
		@q = params[:q]
		@starts_with = params[:starts_with]
		@search = Actor.where("name ILIKE '#{@starts_with}%' ").order("#{@order}").includes(:movies).page(@page).per(20).search(@q)
		@actors = @search.result
		@total_result_count = @actors.total_count
	end

	def show
		@actor = Actor.find(params[:id])
	end

	def new
		@actor = Actor.new
	end	

	def create
		@actor = Actor.new(params[:actor])
		@actor.save
		render "edit"
	end

	def edit
		@actor = Actor.find(params[:id])
		render "edit"
	end

	def update
		@actor = Actor.find(params[:id])
		@actor.update_attributes(params[:actor])
		render "edit"
	end

end