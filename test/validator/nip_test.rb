require 'test_helper'

# All NIP numbers are randomly generated in online generator
module Test
  module Validator
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

      def test_when_proper_nip_with_whitespaces
        validator = NipPeselRegon::Validator::Nip.new(' 14 64 79 18 22 ')
        assert validator.valid?
      end

      def test_when_proper_nip_with_dashes
        validator = NipPeselRegon::Validator::Nip.new('14-64-79-18-22')
        assert validator.valid?
      end

      def test_that_improper_characters_prevent_validation
        validator = NipPeselRegon::Validator::Nip.new('14-64-79-18_22')
        refute validator.valid?
      end

      def test_when_proper_nip_with_proper_polish_country_prefix
        validator = NipPeselRegon::Validator::Nip.new(' PL 14-64-79-18-22')
        assert validator.valid?, 'PL 14-64-79-18-22 should pass validation test'

        validator = NipPeselRegon::Validator::Nip.new('PL1464791822')
        assert validator.valid?, 'PL1464791822 should pass validation test'
      end

      def test_that_proper_polish_country_prefix_can_be_lowercase
        validator = NipPeselRegon::Validator::Nip.new('pl 1464791822')
        assert validator.valid?
      end

      def test_when_proper_nip_with_improper_polish_country_prefix
        validator = NipPeselRegon::Validator::Nip.new('(PL)1464791822')
        refute validator.valid?
      end

      def test_when_proper_nip_with_not_polish_country_prefix
        validator = NipPeselRegon::Validator::Nip.new('DE1464791822')
        refute validator.valid?
      end

      # strict tests
      def test_that_proper_nip_validates_when_strict
        validator = NipPeselRegon::Validator::Nip.new('1464791822', strict: true)
        assert validator.valid?
      end

      def test_that_proper_nip_with_polish_prefix_validates_when_strict
        validator = NipPeselRegon::Validator::Nip.new('PL1464791822', strict: true)
        assert validator.valid?
      end

      def test_that_improperly_formatted_nip_with_polish_prefix_do_not_validate_when_strict
        validator = NipPeselRegon::Validator::Nip.new('PL 1464791822', strict: true)
        refute validator.valid?
      end

      def test_that_improperly_formatted_nip_do_not_validate_when_strict
        validator = NipPeselRegon::Validator::Nip.new('14-64-79-18-22', strict: true)
        refute validator.valid?
      end

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
  end
end