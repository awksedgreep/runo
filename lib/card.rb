# frozen_string_literal: true

##
# Card class represents a single card in the deck
class Card
  # What color am I
  attr_accessor :color
  # What is my internal value
  attr_accessor :internal_value
  # have I been penalized
  attr_accessor :penalized

  # New args internal_value and color
  def initialize(internal_value, color)
    @internal_value = internal_value
    @color = color
  end

  # Point value is 50 for wild cards, 20 for reverse/skip/draw 2, face value for others
  def point_value
    return internal_value if face_value.instance_of?(Integer)
    return 20 if (face_value == 'Reverse') || (face_value == 'Skip') || (face_value == 'Draw 2')

    50 if (face_value == 'Wild') || (face_value == 'Draw 4')
  end

  # returns internal value of card
  def face_value
    Runo::CARDS[internal_value]
  end

  # returns card color
  def face_color
    Runo::COLORS[color]
  end

  # returns a random number between 0 and 1000, used for shuffling
  def sort_value
    rand(1000)
  end

  # returns a string representation of the card
  def to_s
    " #{face_color}" << ' ' << "#{face_value} "
  end
end
