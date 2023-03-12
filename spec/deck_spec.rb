# frozen_string_literal: true

require_relative '../lib/deck'
require 'logger'

describe 'Deck' do
  context 'Should have 108 cards' do
    let(:deck) { Deck.new(Logger.new(nil), 1) }
    it 'should have 108 cards' do
      expect(deck.length).to eq 108
    end
    it 'should have allow you to draw cards' do
      draw_card = deck.draw_card
      expect(draw_card.class).to eq Card
      expect(deck.length).to eq 107
    end
  end
end
