require 'test_helper'

# @todo - check if add namespace here
# All PESEL numbers are randomly generated in online generator
class PeselTest < Minitest::Test

  def test_that_validator_returns_true_for_valid_pesel
    validator = NipPeselRegon::Validator::Pesel.new('00291600815')
    assert validator.valid?
  end


  def test_that_validator_returns_false_for_invalid_pesel
    validator = NipPeselRegon::Validator::Pesel.new('12345678901')
    refute validator.valid?
  end

end