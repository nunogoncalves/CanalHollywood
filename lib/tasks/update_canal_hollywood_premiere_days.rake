namespace :canal_hollywood do

	task :update_canal_hollywood_premiere_days => :environment do
			Movie.all.each do |m|
        premiere = m.canal_hollywood_premiere
        m.canal_hollywood_premiere_year = premiere.year
        m.canal_hollywood_premiere_month = premiere.month
        m.canal_hollywood_premiere_day = premiere.day
        m.canal_hollywood_premiere_day_of_the_week = premiere.wday
        m.save
		end
  end
end

