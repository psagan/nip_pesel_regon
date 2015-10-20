require 'test_helper'

# All REGON numbers are randomly generated in online generator
module Test
  module Validator
    class Regon14Test < Minitest::Test

      def test_when_proper_fixnum_regon
        validator = NipPeselRegon::Validator::Regon14.new(12345678512347)
        assert validator.valid?
      end

      def test_improper_fixnum_regon
        validator = NipPeselRegon::Validator::Regon14.new(12345678512349)
        refute validator.valid?
      end


      def test_when_proper_string_regon
        validator = NipPeselRegon::Validator::Regon14.new('12345678512347')
        assert validator.valid?
      end

      def test_when_improper_string_regon
        validator = NipPeselRegon::Validator::Regon14.new('12345678512349')
        refute validator.valid?
      end

      def test_when_proper_string_regon_with_whitespaces
        regon = ' 12 34 56 78 51 23 47 '
        validator = NipPeselRegon::Validator::Regon14.new(regon)
        assert validator.valid?
      end

      def test_when_proper_regon_with_dashes
        validator = NipPeselRegon::Validator::Regon14.new('12-34-56-78-51-23-47')
        assert validator.valid?
      end

      def test_that_improper_characters_prevent_validation
        validator = NipPeselRegon::Validator::Regon14.new('12-34-56-78-51_23-47')
        refute validator.valid?
      end

      def test_that_proper_regon_validates_when_strict
        validator = NipPeselRegon::Validator::Regon14.new('12345678512347')
        assert validator.valid?
      end

      def test_that_improperly_formatted_regon_do_not_validate_when_strict
        validator = NipPeselRegon::Validator::Regon14.new('12-34-56-78-51-23-47', strict: true)
        refute validator.valid?
      end

      def test_get_original_num
        num = '12-34-56-78-51-23-47'
        validator = NipPeselRegon::Validator::Regon14.new(num)
        validator.valid?
        assert_equal num, validator.original_number
      end

      def test_get_normalized_num
        num = '12-34-56-78-51-23-47'
        validator = NipPeselRegon::Validator::Regon14.new(num)
        validator.valid?
        assert_equal '12345678512347', validator.number
      end

      def test_that_to_string_conversion_returns_normalized_num
        num = '12-34-56-78-51-23-47'
        validator = NipPeselRegon::Validator::Regon14.new(num)
        validator.valid?
        assert_equal '12345678512347', validator.to_s
      end

    end
  end
end
