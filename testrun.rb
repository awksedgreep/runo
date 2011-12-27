class TestRun
  attr_accessor :game
  
  def initialize
    @game = Dealer.new('Mark', 'Wesley', 'Josh', 'Mingjia')
    return nil
  end
end

testrun = TestRun.new