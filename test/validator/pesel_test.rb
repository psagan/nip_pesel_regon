require 'test_helper'

# All PESEL numbers are randomly generated in online generator
module Test
  module Validator
    class PeselTest < Minitest::Test

      def test_that_validator_returns_true_for_valid_pesel
        validator = NipPeselRegon::Validator::Pesel.new('00291600815')
        assert validator.valid?
      end


      def test_that_validator_returns_false_for_invalid_pesel
        validator = NipPeselRegon::Validator::Pesel.new('12345678901')
        refute validator.valid?
      end

      def test_when_proper_pesel_with_whitespaces
        validator = NipPeselRegon::Validator::Pesel.new(' 00 29 16 00 815 ')
        assert validator.valid?
      end

      def test_when_proper_pesel_with_dashes
        validator = NipPeselRegon::Validator::Pesel.new('00-29-16-00-815')
        assert validator.valid?
      end

      def test_that_improper_characters_prevent_validation
        validator = NipPeselRegon::Validator::Pesel.new('00-29-16-00_815')
        refute validator.valid?
      end

      def test_that_proper_pesel_validates_when_strict
        validator = NipPeselRegon::Validator::Pesel.new('00291600815', strict: true)
        assert validator.valid?
      end

      def test_that_improperly_formatted_pesel_do_not_validate_when_strict
        validator = NipPeselRegon::Validator::Pesel.new('00-29-16-00-815', strict: true)
        refute validator.valid?
      end

      def test_get_original_num
        num = '00-29-16-00-815'
        validator = NipPeselRegon::Validator::Pesel.new(num)
        validator.valid?
        assert_equal num, validator.original_number
      end

      def test_get_normalized_num
        num = '00-29-16-00-815'
        validator = NipPeselRegon::Validator::Pesel.new(num)
        validator.valid?
        assert_equal '00291600815', validator.number
      end

      def test_that_to_string_conversion_returns_normalized_num
        num = '00-29-16-00-815'
        validator = NipPeselRegon::Validator::Pesel.new(num)
        validator.valid?
        assert_equal '00291600815', validator.to_s
      end

    end
  end
end
