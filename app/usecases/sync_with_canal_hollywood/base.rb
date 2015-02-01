module SyncWithCanalHollywood
  class Base < UseCase::Base

    depends CalculateDateRangeToSyncWith,
            StartReport,
            GetSchedulesOfDates,
            GetMoviesFullInformation,
            SaveSchedules,
            EndReport
  end
end
