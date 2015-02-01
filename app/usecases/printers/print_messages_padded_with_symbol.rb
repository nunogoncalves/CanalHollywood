module Printers
  class PrintMessagesPaddedWithSymbol < Printer

    def print_messages(color = 'white')
      sym = chosen_symbol_or_default
      messages.each do |message|
        length = message.length
        length += 1 if odd?(length)
        num_of_syms = (100 - (message.length)) / 2
        new_message = build_message_padded(message, num_of_syms, sym)
        print_message(new_message, color)
      end
    end

    def print_message(_message, color="white")
      puts _message.color(color)
    end

    def chosen_symbol_or_default
      context.symbol || "#"
    end

    def build_message_padded(message, n, sym)
      n = 1 if n < 1
      "#{sym}"*n + " #{message} " + "#{sym}"*n
    end

  end

end
