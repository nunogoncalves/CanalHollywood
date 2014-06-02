module Printers
  class PrintPrettyBoxedMessages < Printer

    def print_messages
        p '#' * 100
        messages.each { |message| print_message(message) }
        p '#' * 100
    end

  end

end
