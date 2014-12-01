module Printers
  class PrintPrettyBoxedMessages < Printer

    def print_messages(c = 'white')
      edge = "#{'#' * 100}".color(c)
      puts edge
      messages.each { |message| print_message(message, c) }
      puts edge
    end

  end

end
