module Printers
  class Printer < UseCase::Base

    attr_accessor :messages

    def perform
      @messages = context.messages
      print_messages
    end

    def print_message(message)
      length = message.length
      if odd?(length)
        --length
        message = "#{message} "
      end
      p "#####{x_times(length)} #{message} #{x_times(length)}####"
    end

    def odd?(value)
      value % 2 != 0
    end

    def x_times(x)
      times = ((90 - x) / 2)
      return "" if times < 1
      " "*times
    end

  end

end
