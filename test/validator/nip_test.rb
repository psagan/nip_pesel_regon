require 'test_helper'

# @todo - check if add namespace here
class NipTest < Minitest::Test

  def test_when_proper_fixnum_nip
    validator = NipPeselRegon::Validator::Nip.new(5882247715)
    assert validator.valid?
  end

  def test_when_improper_fixnum_nip
    validator = NipPeselRegon::Validator::Nip.new(5882247716)
    refute validator.valid?
  end

  def test_when_proper_string_nip
    validator = NipPeselRegon::Validator::Nip.new('5882247715')
    assert validator.valid?
  end

  def test_when_improper_string_nip
    validator = NipPeselRegon::Validator::Nip.new('5882247716')
    refute validator.valid?
  end

end