module SyncWithCanalHollywood
  class StartReport < UseCase::Base

    def perform
      context.report_start = DateTime.now

      date_range = context.date_range
      messages = 'Fetching Movies', "FROM: #{date_range.start_date} TO: #{date_range.end_date}"
      Printers::PrintPrettyBoxedMessages.perform(messages: messages, color: 'light_blue')
    end

  end
end
