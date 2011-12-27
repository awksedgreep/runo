#!/usr/bin/env ruby

require 'rubygems'
require 'colored'

# face values for internal value
CARDS = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'Reverse', 'Skip', 'Draw 2', 'Wild', 'Draw 4']
COLORS = ['Red', 'Green', 'Blue', 'Yellow', 'Black']

class Deck
  attr_accessor :cards

  def initialize(number_of_decks = 1)
    @cards = []
    (0..number_of_decks).each do
      # Two of each 1-9, Reverse, Skip, Draw 2 in each color
      (0..3).each do |color|
        (1..12).each do |internal_value|
          @cards << Card.new(internal_value, color)
          @cards << Card.new(internal_value, color)
        end
      end
      # One of each 0 in each color
      (0..3).each do |color|
        @cards << Card.new(0, color)
      end
      # Four Wilds, no color/black
      (0..3).each do
        @cards << Card.new(13,4)
        @cards << Card.new(14,4)
      end
    end
  end

  def draw_card
    @cards.shift
  end
  
  def shuffle
    @cards = @cards.sort_by { |card| card.sort_val }
  end
  
  def each_card
    if block_given?
      @cards.each do |card|
        yield card
      end
    end
  end
  
  def length
    @cards.length
  end
end

class Card
  attr_accessor :color, :internal_value, :penalized

  def initialize(internal_value, color)
    @internal_value = internal_value
    @color = color
  end
 
  def point_value
    return internal_value if face_value.class == Fixnum
    return 20 if (face_value == 'Reverse' or face_value == 'Skip' or face_value == 'Draw 2')
    return 50 if (face_value == 'Wild' or face_value == 'Draw 4')
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
    result = (" #{face_color}" << " " << "#{face_value} ").white.send("on_" + face_color.downcase).bold unless face_color == 'Black'
    result = (" #{face_color}" << " " << "#{face_value} ").black_on_white.bold if face_color == 'Black'
    result
  end
end
