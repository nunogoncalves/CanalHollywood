module ApplicationHelper

	def next_day_text(date)
		formatted_date(date + 1.days)
	end

	def previous_day_text(date)
		formatted_date(date - 1.days)
	end

	def current_date_formatted(date)
		I18n.l(date, format: "%A, %d de %B de %Y")
	end

	def next_month_text(date)
		formatter_month(date.beginning_of_month.next_month)
	end

	def next_month_submit_date(date)
		formatted_date(date.beginning_of_month.next_month)
	end

	def previous_month_submit_date(date)
		formatted_date(date - 1.month)
	end

	def previous_month_text(date)
		formatter_month(date - 1.month)
	end

	def current_month_formatted(date)
		I18n.l(date, format: "%B de %Y")
	end

	def get_zero_based_date_str(date)
		"#{date.year}-#{date.month}-#{date.day}"
	end

	def set_order_class?(field_name)
		return false if @searcher.blank?
		@searcher.order == "#{field_name} asc" || @searcher.order == "#{field_name} desc"
	end 

	private # ----------------------------------------- private 

	def formatted_date(date)
		date.strftime("%Y-%m-%d")
	end

	def formatter_month(date)
		I18n.l(date, format: "%B de %Y")
	end
end
