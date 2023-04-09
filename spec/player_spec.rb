# frozen_string_literal: true

require_relative '../lib/player'
require 'logger'

describe 'Player' do
  context 'should exist' do
    let(:log) { Logger.new(nil) }
    let(:dealer) { Dealer.new(log: log, players: ['Mark'], human_players: []) }
    let(:player) { dealer.players.first }
    it 'should the name Mark' do
      expect(player.name).to eq 'Mark'
    end
    it 'should have 7 cards in his hand' do
      expect(player.cards.length).to eq 7
    end
    it 'should draw cards' do
      player.draw_card
      expect(player.cards.length).to eq 8
    end
    it 'should play cards' do
      first_card = player.cards.first
      top_card = first_card
      card = player.play_card(top_card)
      expect(card.class).to eq Card
      expect(player.cards.length).to eq 6
    end
    it 'should find a playable card' do
      first_card = player.cards.first
      top_card = first_card
      card = player.which_card(top_card)
      expect(card.class).to eq Card
    end
  end
end
