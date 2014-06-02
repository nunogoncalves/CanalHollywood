module SyncWithCanalHollywood
  class EndReport < UseCase::Base

    def perform
      report_start = context.report_start
      messages = ["Took #{DateTime.now.to_i - report_start.to_i} seconds"]
      Printers::PrintPrettyBoxedMessages.perform(messages: messages)
    end

  end
end
