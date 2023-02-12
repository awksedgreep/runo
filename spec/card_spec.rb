# frozen_string_literal: true

require_relative '../lib/card'
require_relative '../lib/deck'

describe 'Card' do
  # Wild Card rspec
  context 'the card should be wild' do
    let(:card) { Card.new(13, Runo::BLACK) }
    it 'should be black' do
      expect(card.color).to eq(Runo::BLACK)
      expect(card.face_color).to eq('Black')
    end
    it 'should be a wild card' do
      expect(card.internal_value).to eq 13
      expect(card.face_value).to eq 'Wild'
    end
    it 'should have a point value of 50' do
      expect(card.point_value).to eq 50
    end
    it 'should return a sort value of 1-1000 of type int' do
      expect(card.sort_value).to be > 0
      expect(card.sort_value).to be < 1001
      expect(card.sort_value).to be_an Integer
    end
    it 'should be a black wild when asked' do
      expect(card.to_s).to eq ' Black Wild '
    end
    it 'should not be a penalized card' do
      expect(card.penalized).to be_falsy
    end
  end
  # Draw 4 Rspec
  context 'the card should be a Draw 4' do
    let(:card) { Card.new(14, Runo::BLACK) }
    it 'should be black' do
      expect(card.color).to eq(Runo::BLACK)
      expect(card.face_color).to eq('Black')
    end
    it 'should be a Draw 4' do
      expect(card.internal_value).to eq 14
      expect(card.face_value).to eq 'Draw 4'
    end
    it 'should have a point value of 50' do
      expect(card.point_value).to eq 50
    end
    it 'should return a sort value of 1-1000 of type int' do
      expect(card.sort_value).to be > 0
      expect(card.sort_value).to be < 1001
      expect(card.sort_value).to be_an Integer
    end
    it 'should be a black draw 4 when asked' do
      expect(card.to_s).to eq ' Black Draw 4 '
    end
    it 'should not be a penalized card' do
      expect(card.penalized).to be_falsy
    end
  end
  # Draw 2 Rspec
  context 'the card should be a red Draw 2' do
    let(:card) { Card.new(12, Runo::RED) }
    it 'should be red' do
      expect(card.color).to eq(Runo::RED)
      expect(card.face_color).to eq('Red')
    end
    it 'should be a red Draw 2' do
      expect(card.internal_value).to eq 14
      expect(card.face_value).to eq 'Draw 4'
    end
    it 'should have a point value of 50' do
      expect(card.point_value).to eq 50
    end
    it 'should return a sort value of 1-1000 of type int' do
      expect(card.sort_value).to be > 0
      expect(card.sort_value).to be < 1001
      expect(card.sort_value).to be_an Integer
    end
    it 'should be a black draw 4 when asked' do
      expect(card.to_s).to eq ' Black Draw 4 '
    end
    it 'should not be a penalized card' do
      expect(card.penalized).to be_falsy
    end
  end
end
