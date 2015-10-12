require 'test_helper'
require 'supermodel'
require "nip_pesel_regon/integration/rails"

module Test
  module Integration
    module Rails
      module Pesel
        class CompanyBase < SuperModel::Base
          extend ActiveModel::Validations::HelperMethods
        end

        class Company < CompanyBase
          validates_pesel_of :pesel
        end

        class CompanyWithStrictPeselTrue < CompanyBase
          validates_pesel_of :pesel, strict: true
        end

        class CompanyWithStrictPeselFalse < CompanyBase
          validates_pesel_of :pesel, strict: false
        end

        class CompanyWithCustomMessage < CompanyBase
          validates_pesel_of :pesel, message: 'test msg'
        end

        class CompanyWithRawPesel < CompanyBase
          validates_pesel_of :pesel, save_normalized: false
        end

        class PeselTest < Minitest::Test

          def test_that_pesel_validates_properly_in_model
            c = Company.new(pesel: '00291600815')
            assert c.valid?
          end

          def test_that_improper_pesel_do_not_validate_in_model
            c = Company.new(pesel: '12345678901')
            refute c.valid?
          end

          def test_that_proper_formatted_pesel_do_not_validate_in_model_when_strict
            c = CompanyWithStrictPeselTrue.new(pesel: '00-29-16-00815')
            refute c.valid?
          end

          def test_that_proper_formatted_pesel_validates_in_model_when_strict_set_to_false
            c = CompanyWithStrictPeselFalse.new(pesel: '00-29-16-00815')
            assert c.valid?
          end

          def test_that_validation_of_not_proper_pesel_adds_default_error_message
            c = Company.new(pesel: '00291600817')
            refute c.valid?
            assert_equal 1 , c.errors[:pesel].size
            assert_equal 'invalid PESEL', c.errors[:pesel].first
          end

          def test_that_validation_of_not_proper_pesel_adds_custom_error_message
            c = CompanyWithCustomMessage.new(pesel: '00291600817')
            refute c.valid?
            assert_equal 1 , c.errors[:pesel].size
            assert_equal 'test msg', c.errors[:pesel].first
          end

          def test_that_save_model_saves_normalized_number_by_default
            c = Company.new(pesel: '00291600815')
            c.save!
            assert_equal '00291600815', c.pesel
          end

          def test_that_save_model_saves_raw_number_when_proper_options_set
            c = CompanyWithRawPesel.new(pesel: '00-29-16-00815')
            c.save!
            assert_equal '00-29-16-00815', c.pesel
          end

        end
      end
    end
  end
end


