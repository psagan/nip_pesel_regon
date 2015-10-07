require 'test_helper'

# @todo - check if add namespace here
class PeselTest < Minitest::Test

  def test_when_improper_fixnum_pesel
    validator = NipPeselRegon::Validator::Pesel.new(12345678901)
    refute validator.valid?
  end

end