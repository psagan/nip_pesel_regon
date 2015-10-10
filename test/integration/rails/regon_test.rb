require 'test_helper'
require 'supermodel'
require "nip_pesel_regon/integration/rails"

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
            c = Company.new(regon: '221021005')
            assert c.valid?
          end

          def test_that_improper_regon_do_not_validate_in_model
            c = Company.new(regon: '221021006')
            refute c.valid?
          end

        end
      end
    end
  end
end


