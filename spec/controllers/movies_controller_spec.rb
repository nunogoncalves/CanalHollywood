require 'spec_helper'

describe MoviesController do
  describe 'PUT#SYNC' do
    it 'should create movies' do
      VCR.use_cassette('schedules_cassette') do
        put 'sync'
        expect(Movie.count).to be(303)
      end
    end
  end
end