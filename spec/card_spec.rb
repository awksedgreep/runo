# frozen_string_literal: true

require_relative '../lib/card'
require_relative '../lib/deck'

describe 'Card' do
  # Wild Card rspec
  context 'the card should be wild' do
    let(:card) { Card.new(13, RunoCards::BLACK) }
    it 'should be black' do
      expect(card.color).to eq(RunoCards::BLACK)
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
      expect(card.card_string).to eq ' Black Wild '
    end
    it 'should not be a penalized card' do
      expect(card.penalized).to be_falsy
    end
  end
  # Draw 4 Rspec
  context 'the card should be a Draw 4' do
    let(:card) { Card.new(14, RunoCards::BLACK) }
    it 'should be black' do
      expect(card.color).to eq(RunoCards::BLACK)
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
      expect(card.card_string).to eq ' Black Draw 4 '
    end
    it 'should not be a penalized card' do
      expect(card.penalized).to be_falsy
    end
  end
  # Draw 2 Rspec
  context 'the card should be a red Draw 2' do
    let(:card) { Card.new(12, RunoCards::RED) }
    it 'should be red' do
      expect(card.color).to eq(RunoCards::RED)
      expect(card.face_color).to eq('Red')
    end
    it 'should be a red Draw 2' do
      expect(card.internal_value).to eq 12
      expect(card.face_value).to eq 'Draw 2'
    end
    it 'should have a point value of 20' do
      expect(card.point_value).to eq 20
    end
    it 'should return a sort value of 1-1000 of type int' do
      expect(card.sort_value).to be > 0
      expect(card.sort_value).to be < 1001
      expect(card.sort_value).to be_an Integer
    end
    it 'should be a red draw 2 when asked' do
      expect(card.card_string).to eq ' Red Draw 2 '
    end
    it 'should not be a penalized card' do
      expect(card.penalized).to be_falsy
    end
  end
  # Skip Rspec
  context 'the card should be a blue skip' do
    let(:card) { Card.new(11, RunoCards::BLUE) }
    it 'should be blue' do
      expect(card.color).to eq(RunoCards::BLUE)
      expect(card.face_color).to eq('Blue')
    end
    it 'should be a blue skip' do
      expect(card.internal_value).to eq 11
      expect(card.face_value).to eq 'Skip'
    end
    it 'should have a point value of 20' do
      expect(card.point_value).to eq 20
    end
    it 'should return a sort value of 1-1000 of type int' do
      expect(card.sort_value).to be > 0
      expect(card.sort_value).to be < 1001
      expect(card.sort_value).to be_an Integer
    end
    it 'should be a blue skip when asked' do
      expect(card.card_string).to eq ' Blue Skip '
    end
    it 'should not be a penalized card' do
      expect(card.penalized).to be_falsy
    end
  end
  # Green Reverse Rspec
  context 'the card should be a green reverse' do
    let(:card) { Card.new(10, RunoCards::GREEN) }
    it 'should be Green' do
      expect(card.color).to eq(RunoCards::GREEN)
      expect(card.face_color).to eq('Green')
    end
    it 'should be a green reverse' do
      expect(card.internal_value).to eq 10
      expect(card.face_value).to eq 'Reverse'
    end
    it 'should have a point value of 20' do
      expect(card.point_value).to eq 20
    end
    it 'should return a sort value of 1-1000 of type int' do
      expect(card.sort_value).to be > 0
      expect(card.sort_value).to be < 1001
      expect(card.sort_value).to be_an Integer
    end
    it 'should be a green reverse when asked' do
      expect(card.card_string).to eq ' Green Reverse '
    end
    it 'should not be a penalized card' do
      expect(card.penalized).to be_falsy
    end
  end
   # Green Reverse Rspec
  context 'the card should be a green reverse' do
    let(:card) { Card.new(10, RunoCards::GREEN) }
    it 'should be Green' do
      expect(card.color).to eq(RunoCards::GREEN)
      expect(card.face_color).to eq('Green')
    end
    it 'should be a green reverse' do
      expect(card.internal_value).to eq 10
      expect(card.face_value).to eq 'Reverse'
    end
    it 'should have a point value of 20' do
      expect(card.point_value).to eq 20
    end
    it 'should return a sort value of 1-1000 of type int' do
      expect(card.sort_value).to be > 0
      expect(card.sort_value).to be < 1001
      expect(card.sort_value).to be_an Integer
    end
    it 'should be a green reverse when asked' do
      expect(card.card_string).to eq ' Green Reverse '
    end
    it 'should not be a penalized card' do
      expect(card.penalized).to be_falsy
    end
  end
  # Yellow 5 Rspec
  context 'the card should be a yellow 5' do
    let(:card) { Card.new(5, RunoCards::YELLOW) }
    it 'should be Yellow' do
      expect(card.color).to eq(RunoCards::YELLOW)
      expect(card.face_color).to eq('Yellow')
    end
    it 'should be a yellow 5' do
      expect(card.internal_value).to eq 5
      expect(card.face_value).to eq 5
    end
    it 'should have a point value of 5' do
      expect(card.point_value).to eq 5
    end
    it 'should return a sort value of 1-1000 of type int' do
      expect(card.sort_value).to be > 0
      expect(card.sort_value).to be < 1001
      expect(card.sort_value).to be_an Integer
    end
    it 'should be a green reverse when asked' do
      expect(card.card_string).to eq ' Yellow 5 '
    end
    it 'should not be a penalized card' do
      expect(card.penalized).to be_falsy
    end
  end
end
