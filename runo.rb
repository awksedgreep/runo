#!/usr/bin/env ruby
# frozen_string_literal: true

require 'logger'
require_relative './lib/dealer'

# Class for running a single game
class Runo
  # store the game object in this
  attr_accessor :game

  # store the logger object in this
  attr_accessor :log

  # start a test
  def initialize(log: Logger.new('log/runo.log', 3, 1_024_000 * 3),
                 players: %w[Mark Wesley Josh Kim Nick])
    @log = log
    @log.level = Logger::INFO
    @players = players
    @game = Dealer.new(log: @log, players: @players)
  end
end

multi_start = Time.now

runo = nil

ARGV[0].to_i.times do
  runo = Runo.new
end

multi_end = Time.now

runo&.log&.warn { "All #{ARGV[0]} games took #{multi_end - multi_start} seconds" }
