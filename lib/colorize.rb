# frozen_string_literal: true

# Adding color options for strings
class String
  # def black = "\e[30m#{self}\e[0m"

  # Black
  def black = "\e[30m\e[47m#{self}\e[0m"

  # Red
  def red = "\e[31m#{self}\e[0m"

  # Green
  def green = "\e[32m#{self}\e[0m"
  # def brown = "\e[33m#{self}\e[0m"

  # Yellow
  def yellow = "\e[33m#{self}\e[0m"
  # def blue = "\e[34m#{self}\e[0m"

  # Magenta
  def magenta = "\e[35m#{self}\e[0m"

  # Cyan
  def cyan = "\e[36m#{self}\e[0m"

  # Gray
  def gray = "\e[37m#{self}\e[0m"
  # blue looks purple to me.  changing blue to cyan equivalent

  # Blue
  def blue = "\e[36m#{self}\e[0m"

  # Bg Black
  def bg_black = "\e[40m#{self}\e[0m"

  # Bg Red
  def bg_red = "\e[41m#{self}\e[0m"

  # Bg Green
  def bg_green = "\e[42m#{self}\e[0m"

  # Bg Brown
  def bg_brown = "\e[43m#{self}\e[0m"

  # Bg Blue
  def bg_blue = "\e[44m#{self}\e[0m"

  # Bg Magenta
  def bg_magenta = "\e[45m#{self}\e[0m"

  # Bg Cyan
  def bg_cyan = "\e[46m#{self}\e[0m"

  # Bg Gray
  def bg_gray = "\e[47m#{self}\e[0m"

  # Bold
  def bold = "\e[1m#{self}\e[22m"

  # Italic
  def italic = "\e[3m#{self}\e[23m"

  # Underline
  def underline = "\e[4m#{self}\e[24m"

  # Blink
  def blink = "\e[5m#{self}\e[25m"

  # Reverse color
  def reverse_color = "\e[7m#{self}\e[27m"
end
