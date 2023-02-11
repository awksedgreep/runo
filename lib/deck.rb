#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'card'

module Runo
  # face values for internal value
  CARDS = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'Reverse', 'Skip', 'Draw 2', 'Wild', 'Draw 4'].freeze

  # COLOR array with card colors including black
  COLORS = %w[Red Green Blue Yellow Black].freeze

  # Red index is always 0
  RED = 0

  # Green index is always 1
  GREEN = 1

  # Blue index is always 2
  BLUE = 2

  # Yellow index is always 3
  YELLOW = 3

  # Black index is always 4
  BLACK = 4
end

# Stack of cards, may be multiple decks actually
class Deck
  # cards accessor, array of cards in the Deck
  attr_accessor :cards

  # Creates a deck or decks and shuffles it/them
  def initialize(number_of_decks = 1)
    @cards = []
    create_deck(number_of_decks)
  end

  # creates a deck or decks and shuffles them
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
        @cards << Card.new(13, Runo::BLACK)
        @cards << Card.new(14, Runo::BLACK)
      end
    end
  end

  # draw a single card from the deck
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

  # shuffle the cards in the deck
  def shuffle
    @cards = @cards.sort_by { |card| card.sort_val }
  end

  # iterate over the deck
  def each_card
    if block_given?
      @cards.each do |card|
        yield card
      end
    end
  end

  # how many cards in the deck
  def length
    @cards.length
  end
end
