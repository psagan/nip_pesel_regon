require 'test_helper'
require 'supermodel'
require "nip_pesel_regon/integration/rails"


module Test
  module Integration
    module Rails
      module Nip

        class CompanyBase < SuperModel::Base
          extend ActiveModel::Validations::HelperMethods
        end

        class Company < CompanyBase
          validates_nip_of :nip
        end

        class CompanyWithStrictNipTrue < CompanyBase
          validates_nip_of :nip, strict: true
        end

        class CompanyWithStrictNipFalse < CompanyBase
          validates_nip_of :nip, strict: false
        end

        class NipTest < Minitest::Test

          def test_that_nip_validates_properly_in_model
            c = Company.new(nip: '5882247715')
            assert c.valid?
          end

          def test_that_improper_nip_do_not_validate_in_model
            c = Company.new(nip: '5882247716')
            refute c.valid?
          end

          def test_that_proper_formatted_nip_do_not_validate_in_model_when_strict
            Company.validates_nip_of :nip, strict: true
            c = CompanyWithStrictNipTrue.new(nip: '588-224-77-15')
            refute c.valid?
          end

          def test_that_proper_formatted_nip_validates_in_model_when_strict_set_to_false
            c = CompanyWithStrictNipFalse.new(nip: '588-224-77-15')
            assert c.valid?
          end

        end
      end
    end
  end
end

