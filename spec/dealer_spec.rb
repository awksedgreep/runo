# frozen_string_literal: true

require_relative '../lib/dealer'
require 'logger'

describe 'Dealer' do
  context 'Should have 5 players' do
    let(:dealer) { Dealer.new(log: Logger.new(nil), players:
      %w[Kim Wesley Josh Nick], human_players: ['Mark']) }
    it 'should have 5 players' do
      expect(dealer.players.length).to eq 5
    end
    it 'should have a deck with 72 cards (108 - (5 * 7) - 1)' do
      expect(dealer.deck.cards.length).to eq 72
    end
    it 'player one should have 7 cards' do
      expect(dealer.players.first.cards.length).to eq 7
    end
    it 'should have a top card of some kind' do
      expect(dealer.top_card.class).to eq Card
    end
    it 'should start in the forward direction' do
      expect(dealer.direction).to eq 1
    end
    it 'should draw two cards' do
      dealer.draw_two
      expect(dealer.players[dealer.current_player - 1].cards.length).to eq 9
    end
    it 'should draw four cards' do
      dealer.draw_four
      expect(dealer.players[dealer.current_player - 1].cards.length).to eq 11
    end
    it 'should reverse when requested' do
      dealer.reverse
      expect(dealer.direction).to eq (-1)
    end
    it 'should skip when requested' do
      dealer.skip
      expect(dealer.current_player).to eq 1
    end
    it 'should increment player when requested' do
      dealer.increment_player
      expect(dealer.current_player).to eq 1
    end
    it 'should change direction when requested' do
      dealer.change_direction
      expect(dealer.direction).to eq (-1)
    end
    it 'should eventually find a winner' do
      dealer.play_game
      expect(dealer.winner).to be true
    end
    it 'should have total points after a win' do
      expect(dealer.points).to eq dealer.total_points
    end
  end
end
