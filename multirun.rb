#!/usr/bin/env ruby
# frozen_string_literal: true

require 'logger'

# Initialize logger
log = Logger.new('runo.log', 3, 1_024_000 * 3)
log.level = Logger::WARN

require './dealer'

# Class for running a single game
class TestRun
  # store the game object in this
  attr_accessor :game

  # start a test
  def initialize(log:)
    @log = log
    @game = Dealer.new(log: @log, players: %w[Mark Wesley Josh Kim Nick])
  end
end

multi_start = Time.now

1.upto(ARGV[0].to_i) do
  TestRun.new(log: log)
end

multi_end = Time.now

log.warn { "All #{ARGV[0]} games took #{multi_end - multi_start} seconds" }
