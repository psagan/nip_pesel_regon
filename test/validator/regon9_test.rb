require 'test_helper'

# @todo - check if add namespace here
# All REGON numbers are randomly generated in online generator
class Regon9Test < Minitest::Test

  def test_when_proper_fixnum_regon
    validator = NipPeselRegon::Validator::Regon.new(632188483)
    assert validator.valid?
  end

  def test_improper_fixnum_regon
    validator = NipPeselRegon::Validator::Regon.new(632188489)
    refute validator.valid?
  end


  def test_when_proper_string_regon
    validator = NipPeselRegon::Validator::Regon.new('632188483')
    assert validator.valid?
  end

  def test_when_improper_string_regon
    validator = NipPeselRegon::Validator::Regon.new('632188485')
    refute validator.valid?
  end

  def test_when_proper_string_regon_with_whitespaces
    regon = ' 6 3 2 1 8 8 4 8 3 '
    validator = NipPeselRegon::Validator::Regon.new(regon)
    assert validator.valid?
  end

  def test_when_proper_regon_with_dashes
    validator = NipPeselRegon::Validator::Regon.new('632-188-483')
    assert validator.valid?
  end

  def test_that_improper_characters_prevent_validation
    validator = NipPeselRegon::Validator::Regon.new('632-188_483')
    refute validator.valid?
  end

  def test_that_proper_regon_validates_when_strict
    validator = NipPeselRegon::Validator::Regon.new('632188483')
    assert validator.valid?
  end

  def test_that_improperly_formatted_regon_do_not_validate_when_strict
    validator = NipPeselRegon::Validator::Regon.new('632-188-483', strict: true)
    refute validator.valid?
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