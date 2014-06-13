require 'spec_helper'

describe MoviesController do
  describe 'PUT#SYNC' do
    it 'create movies and schedules when database is empty' do
      VCR.use_cassette('old_schedules_cassette') do
      # VCR.use_cassette('new_schedules_cassette') do
        put 'sync'
        # SyncWithCanalHollywood::Base.perform
        expect(Movie.count).to be(303)
        expect(Schedule.count).to be(389)

        time_machine = Movie.find_by_canal_hollywood_url('/programa/79012_0/?mquina-do-tempo-a')
        time_machine_schedules = time_machine.schedules
        expect(time_machine_schedules.count).to eq(3)

        expect(time_machine_schedules.first.start_date_time).to eq('2013-07-01 11:30:00')
        expect(time_machine_schedules.first.end_date_time).to eq('2013-07-01 13:10:00')

        expect(time_machine_schedules.second.start_date_time).to eq('2013-07-15 23:25:00')
        expect(time_machine_schedules.second.end_date_time).to eq('2013-07-16 01:05:00')

        expect(time_machine_schedules.third.start_date_time).to eq('2013-07-20 06:25:00')
        expect(time_machine_schedules.third.end_date_time).to eq('2013-07-20 08:00:00')
      end
    end
  end

  it 'should '
end