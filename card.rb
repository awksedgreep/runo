#!/usr/bin/env ruby
# frozen_string_literal: true

##
# Card class represents a single card in the deck
#
class Card
  attr_accessor :color, :internal_value, :penalized

  def initialize(internal_value, color)
    @internal_value = internal_value
    @color = color
  end

  def point_value
    return internal_value if face_value.instance_of?(Integer)
    return 20 if (face_value == 'Reverse') || (face_value == 'Skip') || (face_value == 'Draw 2')
    50 if (face_value == 'Wild') || (face_value == 'Draw 4')
  end

  def face_value
    CARDS[internal_value]
  end

  def face_color
    COLORS[color]
  end

  def sort_val
    rand(1000)
  end

  def to_s
    " #{face_color}" << ' ' << "#{face_value} "
  end
end
