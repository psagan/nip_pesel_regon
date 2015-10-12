require 'test_helper'
require 'supermodel'
require "nip_pesel_regon/integration/rails"

# All REGON numbers are randomly generated in online generator
module Test
  module Integration
    module Rails
      module Regon

        class CompanyBase < SuperModel::Base
          extend ActiveModel::Validations::HelperMethods
        end

        class Company < CompanyBase
          validates_regon_of :regon
        end

        class CompanyWithStrictRegonTrue < CompanyBase
          validates_regon_of :regon, strict: true
        end

        class CompanyWithStrictRegonFalse < CompanyBase
          validates_regon_of :regon, strict: false
        end

        class CompanyWithCustomMessage < CompanyBase
          validates_regon_of :regon, message: 'test msg'
        end

        class CompanyWithRawRegon < CompanyBase
          validates_regon_of :regon, save_normalized: false
        end

        class RegonTest < Minitest::Test

          def test_that_regon_validates_properly_in_model
            c = Company.new(regon: '632188483')
            assert c.valid?
          end

          def test_that_improper_regon_do_not_validate_in_model
            c = Company.new(regon: '632188480')
            refute c.valid?
          end

          def test_that_proper_formatted_regon_do_not_validate_in_model_when_strict
            c = CompanyWithStrictRegonTrue.new(regon: '632-188-483')
            refute c.valid?
          end

          def test_that_proper_formatted_regon_validates_in_model_when_strict_set_to_false
            c = CompanyWithStrictRegonFalse.new(regon: '632-188-483')
            assert c.valid?
          end

          def test_that_validation_of_not_proper_regon_adds_default_error_message
            c = Company.new(regon: '632188480')
            refute c.valid?
            assert_equal 1 , c.errors[:regon].size
            assert_equal 'invalid REGON', c.errors[:regon].first
          end

          def test_that_validation_of_not_proper_regon_adds_custom_error_message
            c = CompanyWithCustomMessage.new(regon: '632188480')
            refute c.valid?
            assert_equal 1 , c.errors[:regon].size
            assert_equal 'test msg', c.errors[:regon].first
          end

          def test_that_save_model_saves_normalized_number_by_default
            c = Company.new(regon: '632-188-483')
            c.save!
            assert_equal '632188483', c.regon
          end

          def test_that_save_model_saves_raw_number_when_proper_options_set
            c = CompanyWithRawRegon.new(regon: '632-188-483')
            c.save!
            assert_equal '632-188-483', c.regon
          end

        end
      end
    end
  end
end


