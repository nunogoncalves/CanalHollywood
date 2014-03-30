namespace :canal_hollywood do

	task :update_canal_hollywood_id => :environment do
			Movie.all.each do |m|
				str = m.canal_hollywood_url
				str.slice!("/programa/")
				str = str.slice(0..(str.index('/')-1))
				p str
				m.update_attribute("canal_hollywood_id", str)
		end
  end

end

