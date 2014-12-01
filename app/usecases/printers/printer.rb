module Printers
  class Printer < UseCase::Base

    attr_accessor :messages

    def perform
      @messages = context.messages
      print_messages(context.color || 'white')
    end

    def print_messages(color = nil)
      messages.each { |message| print_message(message).color(color) }
    end

    def print_message(message, color)
      length = message.length
      if odd?(length)
        --length
        message = "#{message} "
      end
      puts "#####{x_times(length)} #{message} #{x_times(length)}####".color(color)
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
