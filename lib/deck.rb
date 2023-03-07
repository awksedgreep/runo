# frozen_string_literal: true

require_relative 'card'

module RunoCards
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
  def initialize(log, number_of_decks = 1)
    @log = log
    @cards = []
    create_deck(number_of_decks)
  end

  # creates a deck or decks and shuffles them
  def create_deck(number_of_decks = 1)
    (1..number_of_decks).each do
      4.times do |color|
        # Two of each 1-9, Reverse, Skip, Draw 2 in each color
        (1..12).each do |internal_value|
          @cards << Card.new(internal_value, color)
          @cards << Card.new(internal_value, color)
        end
        # One of each 0 in each color
        @cards << Card.new(0, color)
        # Four Wilds, no color/black
        @cards << Card.new(13, RunoCards::BLACK)
        @cards << Card.new(14, RunoCards::BLACK)
      end
    end
  end

  # draw a single card from the deck
  def draw_card
    if @cards.length < 3
      @log.info { 'Deck nearly empty, shuffle in new deck' }
      create_deck(1)
      shuffle
    end
    @cards.shift
  end

  # shuffle the cards in the deck
  def shuffle
    @cards = @cards.sort_by(&:sort_value)
  end

  # iterate over the deck
  # def each_card
  #  if block_given?
  #     @cards.each do |card|
  #      yield card
  #    end
  #  end
  # end

  # iterate over the deck
  # def each_card(&block)
  #   @cards.each(&block) if block_given?
  # end

  # how many cards in the deck
  def length
    @cards.length
  end
end
