module Printers
  class PrintSimpleMessages < Printer

    def print_messages(c = 'white')
      messages.each { |message| print_message(message, c) }
    end

  end

end
