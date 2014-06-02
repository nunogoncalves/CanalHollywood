module Printers
  class PrintSimpleMessages < Printer

    def print_messages
      messages.each { |message| print_message(message) }
    end

  end

end
