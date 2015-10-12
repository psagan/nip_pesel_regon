require 'test_helper'
require 'supermodel'
require "nip_pesel_regon/integration/rails"

# All REGON numbers are randomly generated in online generator
module Test
  module Integration
    module Rails
      module Regon
        class Company < SuperModel::Base
          extend ActiveModel::Validations::HelperMethods
          validates_regon_of :regon
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

        end
      end
    end
  end
end


