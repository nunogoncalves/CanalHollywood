class DateRange

	attr_accessor :start_date, :end_date

	def initialize(start_date = Date.new, end_date = Date.new)
		@start_date = start_date
		@end_date = end_date	
	end

	def days_of_range
		start_date.to_date.upto(end_date.to_date).map { |day| day }
	end

end