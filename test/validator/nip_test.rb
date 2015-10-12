require 'test_helper'

# @todo - check if add namespace here
# # All NIP numbers are randomly generated in online generator
class NipTest < Minitest::Test

  def test_when_proper_fixnum_nip
    validator = NipPeselRegon::Validator::Nip.new(1464791822)
    assert validator.valid?
  end

  def test_when_improper_fixnum_nip
    validator = NipPeselRegon::Validator::Nip.new(1464791824)
    refute validator.valid?
  end

  def test_when_proper_string_nip
    validator = NipPeselRegon::Validator::Nip.new('1464791822')
    assert validator.valid?
  end

  def test_when_improper_string_nip
    validator = NipPeselRegon::Validator::Nip.new('1464791824')
    refute validator.valid?
  end

  # @todo - more tests on different formats with PL, DE, EN ....

  def test_get_original_num
    num = '146-479-18-22'
    validator = NipPeselRegon::Validator::Nip.new(num)
    validator.valid?
    assert_equal num, validator.original_number
  end

  def test_get_normalized_num
    num = '146-479-18-22'
    validator = NipPeselRegon::Validator::Nip.new(num)
    validator.valid?
    assert_equal '1464791822', validator.number
  end

  def test_that_to_string_conversion_returns_normalized_num
    num = '146-479-18-22'
    validator = NipPeselRegon::Validator::Nip.new(num)
    validator.valid?
    assert_equal '1464791822', validator.to_s
  end

end