require 'test_helper'

# @todo - check if add namespace here
class ChecksumTest < Minitest::Test

  def test_proper_checksum
    weights = [ 2, 3, 4]
    number = '123'

    calculator = NipPeselRegon::Calculator::Checksum.new(weights, number)
    assert_equal 20, calculator.calculate
  end

end