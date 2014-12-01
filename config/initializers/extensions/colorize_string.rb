class String
  COLOR_CODES = {
    'white'      => 29,
    'black'      => 30,
    'red'        => 31,
    'green'      => 32,
    'yellow'     => 33,
    'blue'       => 34,
    'pink'       => 35,
    'light_blue' => 36,
  }

  COLOR_CODES.each do |color, code|
    define_method("#{color}") do
      colorize_by_code(code)
    end
  end

  def color(color_name = 'white')
    return send("#{color_name}") if COLOR_CODES.has_key?(color_name)
    white
  end

  def colorize_by_code(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end
end