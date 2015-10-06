require 'test_helper'

# @todo - check if add namespace here
class RegonTest < Minitest::Test

  def test_when_proper_fixnum_regon
    validator = NipPeselRegon::Validator::Regon.new(221021005)
    assert validator.valid?
  end

  def test_when_proper_string_regon_with_whitespaces
    regon = '1 2 3 4 5 6 7 8 5 1 2 3 4 7'
    validator = NipPeselRegon::Validator::Regon.new(regon)
    assert validator.valid?
  end

end