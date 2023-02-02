#!/usr/bin/env ruby
# frozen_string_literal: true

require './dealer'

# Run the test
class TestRun
  attr_accessor :game

  def initialize
    @game = Dealer.new('Mark', 'Wesley', 'Josh', 'Kim', 'Nick')
  end
end

TestRun.new
