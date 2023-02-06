#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'card'

# face values for internal value
CARDS = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'Reverse', 'Skip', 'Draw 2', 'Wild', 'Draw 4'].freeze
COLORS = %w[Red Green Blue Yellow Black].freeze
RED = 0
GREEN = 1
BLUE = 2
YELLOW = 3
BLACK = 4

# Stack of cards, may be multiple decks actually
class Deck
  attr_accessor :cards

  def initialize(number_of_decks = 1)
    @cards = []
    create_deck(number_of_decks)
  end

  def create_deck(number_of_decks = 1)
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
        @cards << Card.new(13, BLACK)
        @cards << Card.new(14, BLACK)
      end
    end
  end

  def draw_card
    if @cards.length > 3
      @cards.shift
    else
      # Deck nearly empty, shuffle in new one 
      create_deck(1)
      shuffle
      @cards.shift
    end
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
