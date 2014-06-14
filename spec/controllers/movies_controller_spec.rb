require 'spec_helper'

describe MoviesController do
  describe 'PUT#SYNC' do
    it 'create movies and schedules when database is empty old method' do
      VCR.use_cassette('old_schedules_cassette') do
        put 'sync'
        expectations
      end
    end

    it 'create movies and schedules when database is empty old method new method' do
      VCR.use_cassette('new_schedules_cassette') do
        SyncWithCanalHollywood::Base.perform
        expectations
      end
    end

    it 'should sync movies when database is not empty old method' do
      VCR.use_cassette('old_multiple_months_schedules_cassette') do
        put 'sync'
        into_the_blue = Movie.find_by_canal_hollywood_url('/programa/89529_0/?profundo-azul');
        expect(into_the_blue.schedules.count).to be(2)

        put 'sync'
        into_the_blue = Movie.find_by_canal_hollywood_url('/programa/89529_0/?profundo-azul');
        expect(into_the_blue.schedules.count).to be(4)
        expectations_2
      end
    end

    it 'should sync movies when database is not empty new method' do
      VCR.use_cassette('new_multiple_months_schedules_cassette') do

        SyncWithCanalHollywood::Base.perform
        into_the_blue = Movie.find_by_canal_hollywood_url('/programa/89529_0/?profundo-azul');
        expect(into_the_blue.schedules.count).to be(2)

        SyncWithCanalHollywood::Base.perform
        expectations_2
        expect(into_the_blue.schedules.count).to be(4)
      end
    end

    def expectations_2
      expect(Movie.count).to be(377)
      expect(Schedule.count).to be(776)
      into_the_blue = Movie.find_by_canal_hollywood_url('/programa/89529_0/?profundo-azul');
    end

    def expectations
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