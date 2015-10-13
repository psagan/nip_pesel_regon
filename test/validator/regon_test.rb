require 'test_helper'

# @todo - check if add namespace here
# All REGON numbers are randomly generated in online generator
# This class is responsible for test only public interface of
# common NipPeselRegon::Validator::Regon proxy class, which
# automatically determines which REGON strategy validation to use.
# Concrete REGON validators unit tests are in different test classes
# responsible for testing them: regon9_test.rb and regon14_test.rb
class RegonTest < Minitest::Test

  def test_when_proper_fixnum_regon
    validator = NipPeselRegon::Validator::Regon.new(632188483)
    assert validator.valid?
  end

  def test_improper_fixnum_regon
    validator = NipPeselRegon::Validator::Regon.new(632188489)
    refute validator.valid?
  end

  def test_that_proper_14_digit_regon_pass_validation
    validator = NipPeselRegon::Validator::Regon.new('12345678512347')
    assert validator.valid?
  end

  def test_that_improper_14_digit_regon_do_not_pass_validation
    validator = NipPeselRegon::Validator::Regon.new('12345678512349')
    refute validator.valid?
  end

  def test_that_proper_9_digit_regon_pass_validation
    validator = NipPeselRegon::Validator::Regon.new('632188483')
    assert validator.valid?
  end

  def test_that_improper_9_digit_regon_do_not_pass_validation
    validator = NipPeselRegon::Validator::Regon.new('632188485')
    refute validator.valid?
  end

  def test_when_proper_string_regon_with_whitespaces
    regon = ' 1 2 3 4 5 6 7 8 5 1 2 3 4 7 '
    validator = NipPeselRegon::Validator::Regon.new(regon)
    assert validator.valid?
  end

  def test_get_original_num
    num = '632-188-483'
    validator = NipPeselRegon::Validator::Regon.new(num)
    validator.valid?
    assert_equal num, validator.original_number
  end

  def test_get_normalized_num
    num = '632-188-483'
    validator = NipPeselRegon::Validator::Regon.new(num)
    validator.valid?
    assert_equal '632188483', validator.number
  end

  def test_that_to_string_conversion_returns_normalized_num
    num = '632-188-483'
    validator = NipPeselRegon::Validator::Regon.new(num)
    validator.valid?
    assert_equal '632188483', validator.to_s
  end

end