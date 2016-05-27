require 'test_helper'

class LotteryTest < ActiveSupport::TestCase
  @l

  Before
  def setup
    self.l = fixtures.lotteries.one
  end

  test "status" do
    assertEquals("Active", l.status)

  end
end
