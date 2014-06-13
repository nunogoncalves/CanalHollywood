module Printers
  class PrintMessagesPaddedWithSymbol < Printer

    def print_messages
      sym = chosen_symbol_or_default
      messages.each do |message|
        num_of_syms = (100 - (message.length)) / 2
        new_message = build_message_padded(message, num_of_syms, sym)
        print_message(new_message)
      end
    end

    def print_message(_message)
      p _message
    end

    def chosen_symbol_or_default
      context.symbol || "#"
    end

    def build_message_padded(message, n, sym)
      "#{sym}"*n + " #{message} " + "#{sym}"*n
    end

  end

end
