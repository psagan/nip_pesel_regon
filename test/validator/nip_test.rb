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

  # @todo - more tests on different formats with PL, DE, EN ....

  def test_get_original_num
    num = '588-224-77-15'
    validator = NipPeselRegon::Validator::Nip.new(num)
    validator.valid?
    assert_equal num, validator.original_number
  end

  def test_get_normalized_num
    num = '588-224-77-15'
    validator = NipPeselRegon::Validator::Nip.new(num)
    validator.valid?
    assert_equal '5882247715', validator.num
  end

  def test_that_to_string_conversion_returns_normalized_num
    num = '588-224-77-15'
    validator = NipPeselRegon::Validator::Nip.new(num)
    validator.valid?
    assert_equal '5882247715', validator.to_s
  end

end